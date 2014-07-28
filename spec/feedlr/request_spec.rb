require 'helper'

describe Feedlr::Request do
  let(:client) { Feedlr::Client.sandbox }
  let(:response) { double(status: 200, body: { a: :b }, headers: {}) }

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
        client.send(:build_object,
                    method: verb, path: '/categories',
                    params: params, headers: headers)
      end

      it 'builds an object' do
        res = client.send(:build_object, method: verb, path: '/categories')
        expect(res).to be_a(Feedlr::Base)
      end
    end

  end

  describe '#request' do

    let(:request) { -> { client.send(:request, :get, '/path', nil) } }

    it 'runs the request and verifies it' do
      response = double
      allow(client).to receive(:run_request).and_return(response)
      allow(response).to receive(:raise_http_errors)
      expect(client).to receive(:run_request)
      expect(response).to receive(:raise_http_errors)
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

  describe '#input_to_payload' do
    it 'it accepts #to_hash input' do
      input = Hashie::Mash.new(a: 1, b: 2)
      expect(client.send(:input_to_payload, input)).to eq(input.to_hash)
    end

    it 'it accepts #to_ary input' do
      input = double(to_ary: %w(x, y))
      expect(client.send(:input_to_payload, input)).to eq(input.to_ary)
    end

    it 'raises TypeError otherwise' do
      expect { client.send(:input_to_payload, 'hello') }
      .to raise_error(TypeError)
    end
  end

  describe '#input_to_params' do
    it 'it accepts #to_ary input' do
      input = Hashie::Mash.new(a: 1, b: 2)
      expect(client.send(:input_to_params, input)).to eq(input.to_hash)
    end

    it 'raises TypeError otherwise' do
      expect { client.send(:input_to_params, 'hello') }
      .to raise_error(TypeError)
    end
  end

end
