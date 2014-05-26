require 'helper'

describe Feedlr::Gateway::Tags, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  let(:tags_ids) do
    ['user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/tag/Amazon',
     'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/tag/Mobile']
  end

  let(:tag_id) { tags_ids.first }

  let(:entries_ids) do
    ['k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777']
  end

  describe '#user_tags' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/tags')
      .to_return(body: '{ }')
      client.user_tags
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_tags
      expect(subject.size).to be >= 2
      expect(subject.first.label).to eq('Amazon')
    end
  end

  describe '#tag_entry' do

    it 'calls tag_entries' do
      allow(client).to receive(:tag_entries)
      expect(client).to receive(:tag_entries)
      .with([entries_ids.first], tags_ids)
      client.tag_entry(entries_ids.first, tags_ids)
    end

  end

  describe '#tag_entries' do
    it 'sends a put request' do
      tags_query = tags_ids.map { |t| CGI.escape(t) }.join(',')
      stub = stub_request(:put,
                          "http://sandbox.feedly.com/v3/tags/#{tags_query}")
      .with(body: MultiJson.dump(entryIds: entries_ids))

      client.tag_entries(entries_ids, tags_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.tag_entries(entries_ids, tags_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#untag_entry' do
    it 'calls untag_entries' do
      allow(client).to receive(:untag_entries)
      expect(client).to receive(:untag_entries)
      .with([entries_ids.first], tags_ids)
      client.untag_entry(entries_ids.first, tags_ids)
    end

  end

  describe '#untag_entries' do

    it 'sends a delete request' do
      tags_query = tags_ids.map { |t| CGI.escape(t) }.join(',')
      entries_query = entries_ids.map { |t| CGI.escape(t) }.join(',')
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/tags/'\
        "#{tags_query}/#{entries_query}")
      client.untag_entries(entries_ids, tags_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.untag_entries(entries_ids, tags_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#change_tag_label' do
    let(:new_label) { 'testing' }
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/tags/'\
        "#{CGI.escape(tag_id)}").with(body: MultiJson.dump(label: new_label))

      client.change_tag_label(tag_id, new_label)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.change_tag_label(tag_id, new_label)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#delete_tag'  do

    it 'calls delete_tags' do
      allow(client).to receive(:delete_tags)
      expect(client).to receive(:delete_tags).with([tag_id])
      client.delete_tag(tag_id)
    end
  end

  describe '#delete_tags'  do
    it 'sends a delete request' do
      tags_query = tags_ids.map { |t| CGI.escape(t) }.join(',')
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/tags/'\
        "#{tags_query}").to_return(body: '{ }')
      client.delete_tags(tags_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.delete_tags(tags_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
