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
        expect {  client.feed(feed_id) }.to raise_error(exception)
      end
    end
  end

  describe '::parse_error' do
    context 'when body is a hash and has errorMessage' do
      it 'returns error status and body errorMessage' do
        body = { 'errorMessage' => error }
        status = '400'
        result = Feedlr::Error.send(:parse_error, status, body)
        expect(result).to eq("Error #{status} - #{body['errorMessage']}")
      end
    end
    context 'when body is a hash and has no errorMessage' do
      it 'returns error status and body errorMessage' do
        body = { 'noErrorMessage' => error }
        status = '400'
        result = Feedlr::Error.send(:parse_error, status, body)
        expect(result).to eq("Error #{status}")
      end
    end
    context 'when body is a not hash' do
      it 'returns error status and body errorMessage' do
        body = error
        status = '400'
        result = Feedlr::Error.send(:parse_error, status, body)
        expect(result).to eq("Error #{status} - #{body}")
      end
    end

  end

end
