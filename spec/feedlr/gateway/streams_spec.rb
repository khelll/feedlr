require 'helper'

describe Feedlr::Gateway::Streams, vcr: { record: :new_episodes } do
  let(:client) { Feedlr::Client.sandbox(oauth_access_token: access_token) }

  let(:stream) do
    'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Entreprenuership'
  end

  let(:options) { { count: '30', unreadOnly: 'true' } }

  describe '#stream_entries_ids' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/streams/'\
        "#{CGI.escape(stream)}/ids")
      .with(query: options.to_hash)
      subject = client.stream_entries_ids(stream, options)
      subject.first
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      result = client.stream_entries_ids(stream, options)
      subject = result.first
      expect(subject.ids.size).to be >= 5
    end
  end

  describe '#stream_entries_contents' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/streams/'\
        "#{CGI.escape(stream)}/contents").with(query: options.to_hash)

      result = client.stream_entries_contents(stream, options)
      result.first
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      result = client.stream_entries_contents(stream, options)
      subject = result.first
      expect(subject.items.size).to be >= 5
    end
  end

end
