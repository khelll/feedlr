require 'helper'

describe Feedlr::Gateway::Shorten, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  describe '#shorten'  do
    let(:entry_id) do
      'k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777'
    end

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/shorten/entries/'\
        "#{CGI.escape(entry_id)}")
      client.shorten_entry(entry_id)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.shorten_entry(entry_id)
      expect(subject.entryId).to eq(entry_id)
      expect(subject.via).to eq('Feedlr sandbox client')
    end
  end

end
