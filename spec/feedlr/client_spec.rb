require 'helper'
require 'logger'

describe Feedlr::Client do
  describe '#sandbox' do
    it 'should default to Feedlr.sandbox if not set' do
      Feedlr.configure do |c|
        c.sandbox = false
        c.logger = nil
      end
      client = Feedlr::Client.new
      expect(client.sandbox).to eq(Feedlr.sandbox)
    end

    it 'should have a value when set' do
      client = Feedlr::Client.new(sandbox: true)
      expect(client.sandbox).to eq(true)
    end
  end

  describe '#oauth_access_token' do
    it 'should default to Feedlr.oauth_access_token if not set' do
      Feedlr.configure { |c| c.oauth_access_token = 'test' }
      client = Feedlr::Client.new
      expect(client.oauth_access_token).to eq(Feedlr.oauth_access_token)
    end

    it 'should be have a value when set' do
      client = Feedlr::Client.new(oauth_access_token: 'new_test')
      expect(client.oauth_access_token).to eq('new_test')
    end
  end

  describe "#oauth_refresh_token" do
    it "should default to Feedlr.oauth_refresh_token if not set" do
      Feedlr.configure { |c| c.oauth_refresh_token = "test" }
      client = Feedlr::Client.new
      expect(client.oauth_refresh_token).to eq(Feedlr.oauth_refresh_token)
    end

    it "should be have a value when set" do
      client = Feedlr::Client.new(oauth_refresh_token: "new_test")
      expect(client.oauth_refresh_token).to eq("new_test")
    end
  end

  describe "#refresh_oauth_token" do
    let(:refresh_oauth_token) { "new_test" }
    let(:client) do
      Feedlr::Client.new(oauth_refresh_token: refresh_oauth_token)
    end
    let(:params) do
      {
        refresh_token: refresh_oauth_token,
        client_id: "feedlydev",
        client_secret: "feedlydev",
        grant_type: "refresh_token",
      }
    end
    let(:arguments) do
      { client: client, method: :post, path: "/auth/token", params: params }
    end
    let(:request) { Feedlr::Request.new(arguments) }

    it "runs a request to refresh the token" do
      expect(Feedlr::Request).to(
        receive(:new).with(arguments).and_return(request)
      )
      expect(request).to receive(:perform)
      client.refresh_oauth_token
    end
  end

  describe '#logger' do
    it 'should default to Feedlr.logger if not set' do
      Feedlr.configure { |c| c.logger = Logger.new(STDOUT) }
      client = Feedlr::Client.new
      expect(client.logger).to eq(Feedlr.logger)
    end

    it 'should be have a value when set' do
      logger = Logger.new(STDOUT)
      client = Feedlr::Client.new(logger: logger)
      expect(client.logger).to eq(logger)
    end
  end

  describe '::sandbox' do
    it 'should create a client with sandbox option' do
      options = { oauth_access_token: 'new_test', logger: Logger.new(STDOUT) }
      allow(Feedlr::Client).to receive(:new)
      expect(Feedlr::Client).to receive(:new)
        .with(options.merge(sandbox: true))
      Feedlr::Client.sandbox(options)
    end
  end

  describe '#sandbox?' do
    it 'should be an alias to #sandbox' do
      client = Feedlr::Client.sandbox
      expect(client.sandbox?).to eq(client.sandbox)
    end
  end

  describe 'sandbox=' do
    it 'should have a boolean value' do
      client = Feedlr::Client.new
      expect(client).to receive(:boolean)
      client.send(:sandbox=, true)
    end
  end
end
