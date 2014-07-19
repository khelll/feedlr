require 'helper'

describe Feedlr::Error  do
  let(:client) { Feedlr::Client.new(sandbox: true) }
  let(:feed_id) { 'feed/http://feeds.engadget.com/weblogsinc/engadget' }
  let(:error) { 'something wrong' }
  describe '#message' do
    it 'returns the error message' do
      error = Feedlr::Error.new('something wrong')
      expect(error.message).to eq('something wrong')
    end
  end

  describe '#rate_limit' do
    it 'returns a rate limit object' do
      error = Feedlr::Error.new('execution expired')
      expect(error.rate_limit).to be_a Feedlr::RateLimit
    end
  end

  Feedlr::Error.errors.each do |status, exception|
    context "when HTTP status is #{ status}" do
      it "raises #{ exception}" do
        stub_request(:post, 'http://sandbox.feedly.com/v3/feeds/.mget')
        .to_return(status: status, body: '{}')
        expect { client.feed(feed_id) }.to raise_error(exception)
      end
    end
  end

end
