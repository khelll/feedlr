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
    before :each do
      data = '
<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
 <body>
  <outline title="MY" icon="">
   <outline title="Coding Horror" type="rss" xmlUrl="http://feeds.feedburner.'\
   'com/codinghorror" htmlUrl="http://www.codinghorror.com/blog/"/>
   <outline title="Git Ready" type="rss" xmlUrl="http://feeds.feedburner.com/'\
   'git-ready" htmlUrl="http://gitready.com/"/>
   <outline title="PragDave" type="rss" xmlUrl="http://pragdave.blogs'\
   '.pragprog.com/pragdave/atom.xml" htmlUrl="http://pragdave.blogs'\
   '.pragprog.com/pragdave/"/>
  </outline>
 </body>
</opml>
'
      @xml_data = StringIO.new(data)
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/opml')
      .with(headers:  { 'Content-Type' => 'text/xml' },
            body: @xml_data.read)
      @xml_data.rewind
      client.import_opml(@xml_data)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.import_opml(@xml_data)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
