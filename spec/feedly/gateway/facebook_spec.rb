require 'helper'

describe Feedlr::Gateway::Facebook, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end
  describe '#unlink_facebook'  do

    it 'sends a delete request' do
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/facebook/auth')

      client.unlink_facebook
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.unlink_facebook
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#facebook_suggestions' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/facebook/'\
        'suggestions')
      client.facebook_suggestions
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.facebook_suggestions
      expect(subject.size).to be >= 1
    end
  end

end
