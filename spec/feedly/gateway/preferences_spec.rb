require 'helper'

describe Feedlr::Gateway::Preferences, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end
  describe '#preferences'  do

    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/preferences')
      .to_return(body: '{ }')
      client.preferences
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.preferences
      expect(subject.size).to be >= 2
    end
  end

  describe '#update_preferences' do
    let(:preferences) do
      { :'category/reviews/entryOverviewSize' => 0,
        :'category/photography/entryOverviewSize' => 7 }
    end
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/preferences')
      .with(body: MultiJson.dump(preferences.to_hash))
      client.update_preferences(preferences)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.update_preferences(preferences)
      expect(subject.gender).to eq('female')
      expect(subject.fullName).to eq('Best lady')
    end
  end

end
