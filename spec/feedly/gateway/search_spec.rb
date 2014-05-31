require 'helper'

describe Feedlr::Gateway::Search, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end
  let(:query) { 'technology' }
  let(:options) { { n: '30' } }
  describe '#search_feeds' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/search/feeds')
      .with(query: { 'q' => query }.merge(options.to_hash))
      client.search_feeds(query, options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.search_feeds(query, options)
      expect(subject.hint).to eq('Technology')
      expect(subject.results.size).to be >= 5
    end
  end

  describe '#search_stream' do
    let(:stream) do
      'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Entreprenuership'
    end

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/search/contents')
      .with(query: { q: query, streamId: stream }.merge(options.to_hash))

      client.search_stream(stream, query, options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.search_stream(stream, query, options)
      expect(subject.items.size).to be >= 5
    end
  end

end
