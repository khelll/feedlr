require 'helper'

describe Feedlr::Request do
  let(:client) { Feedlr::Client.new(sandbox: true) }
  let(:response) { Hashie::Mash.new(status: 200, body: { a: :b }, headers: {}) }
  describe '#build_object' do
    %w(get delete post put).each do |verb|
      before :each do
        allow(client).to receive(verb).and_return(response)
      end

      it 'sends a request' do
        params = { q: 'one', count: '30' }
        headers = { h1: 'h1one', h2: 'h2one' }
        expect(client).to receive(verb)
        .with('/categories', params, headers)
        client.send(:build_object, verb, '/categories', params, headers)
      end

      it 'builds an object' do
        res = client.send(:build_object, verb, '/categories')
        expect(res).to be_a(Feedlr::Base)
      end
    end

  end

  describe '#request' do

    let(:request) { -> { client.send(:request, :get, '/path', nil) } }

    it 'runs the request and verifies it' do
      allow(client).to receive(:run_request)
      allow(client).to receive(:verify_success)
      expect(client).to receive(:run_request)
      expect(client).to receive(:verify_success)
      request.call
    end

    it 'catches and reraises Faraday timeout errors' do
      allow(client).to receive(:run_request)
      .and_raise(Faraday::Error::TimeoutError.new('execution expired'))
      expect(request).to raise_error(Feedlr::Error::RequestTimeout)
    end

    it 'catches and reraises Timeout errors' do
      allow(client).to receive(:run_request)
      .and_raise(Timeout::Error.new('execution expired'))
      expect(request).to raise_error(Feedlr::Error::RequestTimeout)
    end

    it 'catches and reraises Faraday client errors' do
      allow(client).to receive(:run_request)
      .and_raise(Faraday::Error::ClientError.new('connection failed'))
      expect(request).to raise_error(Feedlr::Error)
    end

    it 'catches and reraises JSON::ParserError errors' do
      allow(client).to receive(:run_request)
      .and_raise(JSON::ParserError.new('unexpected token'))
      expect(request).to raise_error(Feedlr::Error)
    end

  end

  describe '#verify_success' do
    it 'raises an exception if response code is not a success' do
      response = Hashie::Mash.new(status: 400, body: { a: :b }, headers: {})
      expect { client.send(:verify_success, response) }
      .to raise_error(Feedlr::Error::BadRequest)
    end
  end

end
