require 'helper'

describe Feedlr::Gateway::Topics, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  describe '#user_topics' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/topics')

      client.user_topics
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_topics
      expect(subject.size).to be >= 1
    end
  end

  describe '#add_topic' do
    let(:topic) do
      { id: 'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/topic/business',
        interest: 'high' }
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/topics')
      .with(body: MultiJson.dump(topic.to_hash))
      client.add_topic(topic)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.add_topic(topic)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#update_topic' do
    let(:topic) do
      { id: 'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/topic/business',
        interest: 'medium' }
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/topics')
      .with(body: MultiJson.dump(topic.to_hash))
      client.update_topic(topic)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.update_topic(topic)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#delete_topic'  do
    let(:topic_id) do
      'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/topic/business'
    end
    it 'sends a delete request' do
      stub = stub_request(:delete,
                          'http://sandbox.feedly.com/v3/topics/'\
                          "#{CGI.escape(topic_id)}")

      client.delete_topic(topic_id)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.delete_topic(topic_id)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
