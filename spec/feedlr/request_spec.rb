require 'helper'

describe Feedlr::Request do
  let(:client) { Feedlr::Client.sandbox }
  describe '#perform' do
    let(:path) { '/something' }
    let(:headers) { { one: 1 } }
    let(:params) { { two: 2 } }
    let(:method) { [:put, :get, :post, :delete].sample }
    it 'should call the client corresponding http method' do
      request = Feedlr::Request.new(client: client,
                                    path: path,
                                    method: method,
                                    headers: headers,
                                    params: params)
      allow(client).to receive(method)
      expect(client).to receive(method).with(path, params, headers)
      request.perform
    end
  end
end
