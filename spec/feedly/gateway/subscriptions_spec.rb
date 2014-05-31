require 'helper'

describe Feedlr::Gateway::Subscriptions, vcr: { record: :new_episodes } do
  let(:client) { Feedlr::Client.sandbox(oauth_access_token: access_token) }

  describe '#user_subscriptions' do

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/subscriptions')
      .to_return(body: '{ }')
      client.user_subscriptions
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_subscriptions
      expect(subject.size).to be > 2
      expect(subject.first.title).to eq('TechCrunch')
    end
  end

  describe '#add_subscription' do
    let(:subscription) do
      { id: 'feed/http://feeds.feedburner.com/design-milk',
        title: 'Design Milk', categories: [
          { id: 'user/96cc52b7-a17f-4ce0-9b38-\
                              de1b6f08f156/category/Design',
            label: 'Design' },
          { id: 'user/96cc52b7-a17f-4ce0-9b38-\
                              de1b6f08f156/category/Art',
            label: 'Art' }] }
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/subscriptions')
      .with(body: MultiJson.dump(subscription.to_hash)).to_return(body: '{ }')
      client.add_subscription(subscription)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.add_subscription(subscription)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#update_subscription' do
    let(:subscription) do
      { id: 'feed/http://feeds.feedburner.com/design-milk',
        title: 'Design Milk', categories: [
          { id: 'user/96cc52b7-a17f-4ce0-9b38-\
                              de1b6f08f156/category/Design',
            label: 'Design' },
          { id: 'user/96cc52b7-a17f-4ce0-9b38-\
                              de1b6f08f156/category/Art',
            label: 'Art' }] }
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/subscriptions')
      .with(body: MultiJson.dump(subscription.to_hash))
      client.update_subscription(subscription)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.update_subscription(subscription)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#delete_subscription'  do
    let(:subscription_id) { 'feed/http://css-tricks.com/feed/' }
    it 'sends a delete request' do
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/'\
        "subscriptions/#{CGI.escape(subscription_id)}")
      client.delete_subscription(subscription_id)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.delete_subscription(subscription_id)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
