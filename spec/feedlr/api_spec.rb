require 'helper'

describe Feedlr::Gateway::API do
  let(:client) { Feedlr::Client.new(sandbox: true) }

  describe '#api_methods' do
    it 'should return a list of methods' do
      expect(client.api_methods.size).to be >= 50
    end
  end
end
