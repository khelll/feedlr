require 'helper'
require 'logger'

describe Feedlr do
  let(:logger) { Logger.new(STDOUT) }

  after(:each) do
    Feedlr.oauth_access_token = nil
    Feedlr.sandbox = false
    Feedlr.logger = nil
  end

  describe '::sandbox' do
    it 'should be in production mode if not set' do
      expect(Feedlr.sandbox).to eq(false)
    end

    it 'should be in sandbox mode if set' do
      Feedlr.configure { |c| c.sandbox = true }
      expect(Feedlr.sandbox).to eq(true)
    end
  end


  describe '::sandbox=' do
    it 'should have a boolean value' do
      allow(Feedlr::Utils).to receive(:boolean)
      expect(Feedlr::Utils).to receive(:boolean)
      Feedlr.configure { |c| c.sandbox = true }
    end
  end

  describe '::logger' do
    it 'should be an instance of NullLogger if not set' do
      expect(Feedlr.logger).to be_a(Feedlr::NullLogger)
    end

    it 'should have the right value if set' do
      Feedlr.configure { |c| c.logger = logger }
      expect(Feedlr.logger).to eq(logger)
    end
  end

  it 'should be able to set the oAuth access token,' \
  'sandbox and logger' do
    Feedlr.oauth_access_token  = 'oauth_access_token'
    Feedlr.sandbox = true
    Feedlr.logger = logger

    expect(Feedlr.oauth_access_token).to eq('oauth_access_token')
    expect(Feedlr.sandbox).to eq(true)
    expect(Feedlr.logger).to eq(logger)
  end

  describe '::configure' do
    it 'should be able to set the oAuth access token,' \
    'sandbox and logger via a configure block' do
      Feedlr.configure do |config|
        config.oauth_access_token  = 'oauth_access_token'
        config.sandbox = true
        config.logger = logger
      end

      expect(Feedlr.oauth_access_token).to eq('oauth_access_token')
      expect(Feedlr.sandbox).to eq(true)
      expect(Feedlr.logger).to eq(logger)
    end

    it 'should return true' do
      res = Feedlr.configure {}
      expect(res).to eq(true)
    end
  end

end
