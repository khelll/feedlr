require 'helper'

describe Feedlr::Gateway::Mixes, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  let(:options) { { count: '30' } }
  describe '#stream_most_engaging' do
    let(:stream) do
      'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Entreprenuership'
    end

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/mixes/contents')
      .with(query: { streamId: stream }.merge(options))
      client.stream_most_engaging(stream, options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.stream_most_engaging(stream, options)
      expect(subject.items.size).to be >= 1
    end
  end

end
