require 'helper'

describe Feedlr::Gateway::Microsoft, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end
  describe '#unlink_microsoft'  do

    it 'sends a delete request' do
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/microsoft/' \
        'liveAuth')
      client.unlink_microsoft
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.unlink_microsoft
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#add_to_onenote' do
    let(:entry_id) do
      'k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777'
    end
    it 'sends a get request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/microsoft/' \
        'oneNoteAdd').with(body: MultiJson.dump(entryId: entry_id))

      client.add_to_onenote(entry_id)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.add_to_onenote(entry_id)
      expect(subject.pageUrl).to be
    end
  end

end
