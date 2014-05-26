require 'helper'

describe Feedlr::Gateway::Streams, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  let(:stream) do
    'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Entreprenuership'
  end

  let(:options) { { count: '30', unreadOnly: 'true' } }

  describe '#stream_entries_ids' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/streams/'\
        "#{CGI.escape(stream)}/ids")
      .with(query: options)
      client.stream_entries_ids(stream, options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.stream_entries_ids(stream, options)
      expect(subject.ids.size).to be >= 5
    end
  end

  describe '#stream_entries_contents' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/streams/'\
        "#{CGI.escape(stream)}/contents").with(query: options)

      client.stream_entries_contents(stream, options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.stream_entries_contents(stream, options)
      expect(subject.items.size).to be >= 5
    end
  end

end
