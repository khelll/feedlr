require 'helper'

describe Feedlr::Gateway::Feeds, vcr: { record: :new_episodes } do
  let(:client) { Feedlr::Client.new(sandbox: true) }

  describe '#feed'  do
    let(:feed_id) { 'feed/http://feeds.engadget.com/weblogsinc/engadget' }

    it 'calls feeds' do
      allow(client).to receive(:feeds).and_return([1])
      expect(client).to receive(:feeds).with([feed_id])
      client.feed(feed_id)
    end
  end

  describe '#feeds' do
    let(:feeds_ids) do
      ['feed/http://feeds.engadget.com/weblogsinc/engadget',
       'feed/http://www.yatzer.com/feed/index.php']
    end

    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/feeds/.mget')
      .with(body: MultiJson.dump(feeds_ids.to_ary))
      client.feeds(feeds_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.feeds(feeds_ids)
      expect(subject.size).to eq(2)
      expect(subject.first.website).to be_instance_of String
    end
  end

end
