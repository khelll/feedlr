# encoding: UTF-8

require 'helper'

describe Feedlr::Response do
  let(:headers) { { test: 123 } }
  let(:status) { 400 }
  let(:body) { 'something' }

  describe 'getters' do
    let(:response) { Feedlr::Response.new(status, headers, body) }
    it 'returns the status code' do
      expect(response.status).to eq(400)
    end

    it 'returns the body' do
      expect(response.body).to eq('something')
    end

    it 'returns the headers' do
      expect(response.headers).to eq(test: 123)
    end
  end

  describe '#raise_http_errors' do
    it 'raises an exception if response code is not a success' do
      response = Feedlr::Response.new(status, headers, body)
      expect { response.raise_http_errors }
      .to raise_error(Feedlr::Error::BadRequest)
    end
  end

  describe '::error_message' do
    let(:error) { 'something wrong' }
    context 'when body is a hash and has errorMessage' do
      it 'returns error status and body errorMessage' do
        body = { 'errorMessage' => error }
        response = Feedlr::Response.new(status, headers, body)
        expect(response.error_message)
        .to eq("Error #{status} - #{body['errorMessage']}")
      end
    end
    context 'when body is ¬ß hash and has no errorMessage' do
      it 'returns error status and body errorMessage' do
        body = { 'noErrorMessage' => error }
        response = Feedlr::Response.new(status, headers, body)
        expect(response.error_message).to eq("Error #{status}")
      end
    end
    context 'when body is a not hash' do
      it 'returns error status and body errorMessage' do
        body = error
        response = Feedlr::Response.new(status, headers, body)
        expect(response.error_message).to eq("Error #{status} - #{body}")
      end
    end

  end
end
