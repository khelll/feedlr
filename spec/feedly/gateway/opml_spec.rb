require 'helper'

describe Feedlr::Gateway::Opml, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end
  describe '#user_opml'  do

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/opml')
      .with(headers: { 'Content-Type' => 'text/xml' })
      client.user_opml
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_opml
      expect(subject.opml.size).to be(3)
    end
  end

  describe '#import_opml'  do
    let(:file_path) { fixture_path('user_feeds.opml') }

    context 'with input responds to #to_str' do
      it 'sends a post request' do
        stub = stub_request(:post, 'http://sandbox.feedly.com/v3/opml')
        .with(headers:  { 'Content-Type' => 'text/xml' },
              body: File.open(file_path).read)
        client.import_opml(file_path)
        expect(stub).to have_been_requested
      end
    end

    context 'with input responds to #read' do
      it 'sends a post request' do
        file = File.open(file_path)
        stub = stub_request(:post, 'http://sandbox.feedly.com/v3/opml')
        .with(headers:  { 'Content-Type' => 'text/xml' },
              body: file.read)
        file.rewind
        client.import_opml(file)
        file.close
        expect(stub).to have_been_requested
      end
    end

    it 'resoponds with hashie object' do
      file = File.open(file_path)
      subject = client.import_opml(file)
      file.close
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
