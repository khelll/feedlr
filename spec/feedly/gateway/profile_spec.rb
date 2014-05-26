require 'helper'

describe Feedlr::Gateway::Profile, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end

  describe '#profile'  do

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/profile')

      client.user_profile
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_profile
      expect(subject.familyName).to eq('al Habache')
      expect(subject.twitterConnected).to eq(false)
    end
  end

  describe '#update_profile' do
    let(:profile) { { gender: 'female', fullName: 'Best lady' } }
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/profile')
      .with(body: MultiJson.dump(profile))
      client.update_profile(profile)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.update_profile(profile)
      expect(subject.gender).to eq('female')
      expect(subject.fullName).to eq('Best lady')
    end
  end

end
