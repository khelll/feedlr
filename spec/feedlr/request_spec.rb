require 'helper'

describe Feedlr::Request do
  let(:client) { Feedlr::Client.sandbox }
  let(:response) { double(status: 200, body: { a: :b }, headers: {}) }
  let(:path) { '/something' }
  let(:headers) { { one: 1 } }
  let(:params) { { two: 2 } }
  let(:method) { [:put, :get, :post, :delete].sample }
  let(:request) do
    Feedlr::Request.new(client: client,
                        path: path,
                        method: method,
                        headers: headers,
                        params: params)
  end

  describe '#perform' do
    let(:perform) { -> { request.send(:perform) } }

    it 'runs the request and verifies it' do
      allow(request).to receive(:run_and_log).and_return(response)
      allow(response).to receive(:raise_http_errors)
      expect(request).to receive(:run_and_log)
      expect(response).to receive(:raise_http_errors)
      perform.call
    end

    it 'catches and reraises Faraday timeout errors' do
      allow(request).to receive(:run)
        .and_raise(Faraday::Error::TimeoutError.new('execution expired'))
      expect(perform).to raise_error(Feedlr::Error::RequestTimeout)
    end

    it 'catches and reraises Timeout errors' do
      allow(request).to receive(:run)
        .and_raise(Timeout::Error.new('execution expired'))
      expect(perform).to raise_error(Feedlr::Error::RequestTimeout)
    end

    it 'catches and reraises Faraday client errors' do
      allow(request).to receive(:run)
        .and_raise(Faraday::Error::ClientError.new('connection failed'))
      expect(perform).to raise_error(Feedlr::Error)
    end

    it 'catches and reraises JSON::ParserError errors' do
      allow(request).to receive(:run)
        .and_raise(JSON::ParserError.new('unexpected token'))
      expect(perform).to raise_error(Feedlr::Error)
    end
  end

  describe '#params_to_payload' do
    it 'it accepts #to_hash input' do
      input = double(to_hash: { a: 1, b: 2 })
      allow(request).to receive(:params).and_return(input)
      expect(request.send(:params_to_payload)).to eq(input.to_hash)
    end

    it 'it accepts #to_ary input' do
      input = double(to_ary: %w(x, y))
      allow(request).to receive(:params).and_return(input)
      expect(request.send(:params_to_payload)).to eq(input.to_ary)
    end

    it 'raises TypeError otherwise' do
      allow(request).to receive(:params).and_return('hello')
      expect { request.send(:params_to_payload) }
        .to raise_error(TypeError)
    end
  end

  describe '#params_to_hash' do
    it 'it accepts #to_ary input' do
      input = double(to_hash: { a: 1, b: 2 })
      allow(request).to receive(:params).and_return(input)
      expect(request.send(:params_to_hash)).to eq(input.to_hash)
    end

    it 'raises TypeError otherwise' do
      allow(request).to receive(:params).and_return('hello')
      expect { request.send(:params_to_hash) }
        .to raise_error(TypeError)
    end
  end
end
