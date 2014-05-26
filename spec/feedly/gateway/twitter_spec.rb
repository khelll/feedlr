require 'helper'

describe Feedlr::Gateway::Twitter, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  describe '#unlink_twitter'  do
    it 'sends a delete request' do
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/twitter/auth')

      client.unlink_twitter
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.unlink_twitter
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#twitter_suggestions' do
    it 'sends a get request' do
      stub = stub_request(:get,
                          'http://sandbox.feedly.com/v3/twitter/suggestions')
      .to_return(body: '{ }')
      client.twitter_suggestions
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.twitter_suggestions
      expect(subject.size).to be >= 1
    end
  end

end
