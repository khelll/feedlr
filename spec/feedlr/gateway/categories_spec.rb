require 'helper'

describe Feedlr::Gateway::Categories, vcr: { record: :new_episodes } do
  let(:client) { Feedlr::Client.sandbox(oauth_access_token: access_token) }

  describe '#user_categories' do
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/categories')
      client.user_categories
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_categories
      expect(subject.size).to be >= 2
      expect(subject.first.label).to eq('Design')
    end
  end

  describe '#change_category_label' do
    let(:category_id) do
      'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Kool'
    end
    let(:new_label) { 'testing' }
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/categories/'\
                          "#{CGI.escape(category_id)}")
      .with(body: MultiJson.dump(label: new_label))
      client.change_category_label(category_id, new_label)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.change_category_label(category_id, new_label)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#delete_category'  do
    let(:category_id) do
      'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Tech'
    end
    it 'sends a delete request' do
      stub = stub_request(:delete, 'http://sandbox.feedly.com/v3/categories/'\
        "#{CGI.escape(category_id)}")
      client.delete_category(category_id)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.delete_category(category_id)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

end
