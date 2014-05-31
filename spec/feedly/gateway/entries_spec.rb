require 'helper'

describe Feedlr::Gateway::Entries, vcr: { record: :new_episodes } do
  let(:client) { Feedlr::Client.sandbox(oauth_access_token: access_token) }

  describe '#user_entry'  do
    let(:entry_id) do
      'k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777'
    end

    it 'calls entries' do
      allow(client).to receive(:user_entries).and_return([1])
      expect(client).to receive(:user_entries).with([entry_id])
      client.user_entry(entry_id)
    end

  end

  describe '#user_entries' do
    let(:entries_ids) do
      ['k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777',
       'IUiZhV1EuO2ZMzIrc2Ak6NlhGjboZ+Yk0rJ8=_14605b9efb5:7a2b:aec60bc9']
    end
    let(:options) { { continuation: nil } }
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/entries/.mget')
      .with(body: MultiJson.dump(continuation: options[:continuation],
                                 ids: entries_ids.to_ary))
      client.user_entries(entries_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_entries(entries_ids)
      expect(subject.size).to be >= 1
      expect(subject.first.author).to eq('Caroline Williamson')
    end
  end

  describe '#add_entry' do
    let(:entry) do
      { title: 'NBCs reviled sci-fi drama Heroes may get a second lease',
        author: 'Nathan Ingraham',
        content: { direction: 'ltr', content: '...html content user wants to' \
                   'associate with this entry..' },
        tags: [{ id: 'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/tag/Mobile' }],
        alternate: [{ type: 'text/html',
                      href: 'http://www.theverge.com/2013/4/17/4236096/nbc-' \
                      'heroes-may-get-a-second-lease-on-life-on-xbox-live' }] }
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/entries')
      .with(body: MultiJson.dump(entry.to_hash))
      .to_return(body: '{ }')
      client.add_entry(entry)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.add_entry(entry)
      expect(subject).to be
    end
  end

end
