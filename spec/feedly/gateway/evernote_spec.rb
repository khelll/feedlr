require 'helper'

describe Feedlr::Gateway::Evernote, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  describe '#unlink_evernote'  do
    it 'sends a delete request' do
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/evernote/auth')

      client.unlink_evernote
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.unlink_evernote
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#evernote_notebooks'  do
    it 'sends a get request' do
      stub = stub_request(:get,
                          'http://sandbox.feedly.com/v3/evernote/notebooks')

      client.evernote_notebooks
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.evernote_notebooks
      expect(subject.notebooks.size).to be >= 1
    end
  end


  describe '#add_to_evernote' do
    let(:entry) do
      { notebookName: 'feedly notebook', comment: 'user comment',
        url: 'http://techcrunch.com/2014/03/05/evernote-adds-handwriting'\
        '-to-its-android-app/',
        notebookType: 'personal',
        notebookGuid: 'bc1815a0-0a56-46aa-9dca-4c8a53a4eb42',
        tags: %w(tag1 tag2) }
    end
    it 'sends a get request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/evernote/note')
      .with(body: MultiJson.dump(entry.to_hash))
      client.add_to_evernote(entry)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.add_to_evernote(entry)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
