require 'helper'

describe Feedlr::Gateway::Markers, vcr: { record: :new_episodes } do
  let(:client) do
    Feedlr::Client.new(sandbox: true, oauth_access_token: access_token)
  end
  let(:feeds_ids) do
    ['feed/http://feeds.engadget.com/weblogsinc/engadget',
     'feed/http://www.yatzer.com/feed/index.php']
  end
  let(:categories_ids) do
    ['user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Tech',
     'user/96cc52b7-a17f-4ce0-9b38-de1b6f08f156/category/Entreprenuership']
  end
  let(:articles_ids) do
    ['qXKMwD+H9w7rc42rGNxj3U1BuAKE5TpW1EZAANkzhmk=_145e2cb3a50:2c3:592195db',
     'qXKMwD+H9w7rc42rGNxj3U1BuAKE5TpW1EZAANkzhmk=_145b9cdf580:544:7f4ba42e']
  end

  describe '#user_unread_counts' do
    let(:options) { { autorefresh: '1' } }
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/markers/counts')
      .with(query: options.to_hash)
      client.user_unread_counts(options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.user_unread_counts(options)
      expect(subject.unreadcounts.size).to be > 1
      expect(subject.unreadcounts.first.count).to be > 1
    end
  end

  describe '#mark_article_as_read' do
    it 'calls mark_articles_as_read' do
      allow(client).to receive(:mark_articles_as_read)
      expect(client).to receive(:mark_articles_as_read)
      .with([articles_ids.first])
      client.mark_article_as_read(articles_ids.first)
    end
  end

  describe '#mark_articles_as_read' do
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
      .with(body: MultiJson.dump(
              entryIds: articles_ids.to_ary,
              action: 'markAsRead',
              type: 'entries'
      ))
      client.mark_articles_as_read(articles_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.mark_articles_as_read(articles_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#mark_article_as_unread' do
    it 'calls mark_articles_as_unread' do
      allow(client).to receive(:mark_articles_as_unread)
      expect(client).to receive(:mark_articles_as_unread)
      .with([articles_ids.first])
      client.mark_article_as_unread(articles_ids.first)
    end
  end

  describe '#mark_articles_as_unread' do
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
      .with(body: MultiJson.dump(
              entryIds: articles_ids.to_ary,
              action: 'keepUnread',
              type: 'entries'
      )).to_return(body: '{ }')
      client.mark_articles_as_unread(articles_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.mark_articles_as_unread(articles_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#mark_feed_as_read' do
    [:lastReadEntryId, :asOf].each do|param|
      context 'with #{param} param' do
        it 'calls mark_feeds_as_read' do
          allow(client).to receive(:mark_feeds_as_read)
          expect(client).to receive(:mark_feeds_as_read)
          .with([feeds_ids.first], { param => 'test' }.to_hash)
          client.mark_feed_as_read(feeds_ids.first, param => 'test')
        end
      end
    end
  end

  describe '#mark_feeds_as_read' do
    context 'with lastReadEntryId param' do
      let(:lastReadEntryId) do
        'k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777'
      end
      it 'sends a post request' do
        stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
        .with(body: MultiJson.dump(
                feedIds: feeds_ids.to_ary,
                action: 'markAsRead',
                type: 'feeds',
                lastReadEntryId: lastReadEntryId
        )).to_return(body: '{ }')
        client.mark_feeds_as_read(feeds_ids, lastReadEntryId: lastReadEntryId)
        expect(stub).to have_been_requested
      end

      it 'resoponds with hashie object' do
        subject = client.mark_feeds_as_read(feeds_ids,
                                            lastReadEntryId: lastReadEntryId)
        expect(subject).to be_a(Feedlr::Success)
      end
    end

    context 'with asOf param' do
      let(:asOf) { '1400876097' }
      it 'sends a post request' do
        stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
        .with(body: MultiJson.dump(
                feedIds: feeds_ids.to_ary,
                action: 'markAsRead',
                type: 'feeds',
                asOf: asOf
        )).to_return(body: '{ }')
        client.mark_feeds_as_read(feeds_ids, asOf: asOf)
        expect(stub).to have_been_requested
      end

      it 'resoponds with hashie object' do
        subject = client.mark_feeds_as_read(feeds_ids, asOf: asOf)
        expect(subject).to be_a(Feedlr::Success)
      end
    end

  end

  describe '#mark_category_as_read' do
    [:lastReadEntryId, :asOf].each do |param|
      context 'with #{ param} param' do
        it 'calls mark_categories_as_read' do
          allow(client).to receive(:mark_categories_as_read)
          expect(client).to receive(:mark_categories_as_read)
          .with([categories_ids.first], { param => 'test' }.to_hash)
          client.mark_category_as_read(categories_ids.first,
                                       param => 'test')
        end
      end
    end
  end

  describe '#mark_categories_as_read' do
    context 'with lastReadEntryId param' do
      let(:lastReadEntryId) do
        'k3wM4lkt2uyzklIaZG/piLCFwWpRsuSz4luWQLHP0YY=_142814c6526:338b:2190d777'
      end
      it 'sends a post request' do
        stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
        .with(body: MultiJson.dump(
                categoryIds: categories_ids.to_ary,
                action: 'markAsRead',
                type: 'categories',
                lastReadEntryId: lastReadEntryId
        )).to_return(body: '{ }')
        client.mark_categories_as_read(categories_ids,
                                       lastReadEntryId: lastReadEntryId)
        expect(stub).to have_been_requested
      end

      it 'resoponds with hashie object' do
        subject = client.mark_categories_as_read(categories_ids,
                                                 lastReadEntryId:
                                                 lastReadEntryId)
        expect(subject).to be_a(Feedlr::Success)
      end
    end

    context 'with asOf param' do
      let(:asOf) { '1400876097' }
      it 'sends a post request' do
        stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
        .with(body: MultiJson.dump(
                categoryIds: categories_ids.to_ary,
                action: 'markAsRead',
                type: 'categories',
                asOf: asOf
        )).to_return(body: '{ }')
        client.mark_categories_as_read(categories_ids, asOf: asOf)
        expect(stub).to have_been_requested
      end

      it 'resoponds with hashie object' do
        subject = client.mark_categories_as_read(categories_ids, asOf: asOf)
        expect(subject).to be_a(Feedlr::Success)
      end
    end

  end

  describe '#undo_mark_feed_as_read' do
    it 'calls undo_mark_feeds_as_read' do
      allow(client).to receive(:undo_mark_feeds_as_read)
      expect(client).to receive(:undo_mark_feeds_as_read)
      .with([feeds_ids.first])
      client.undo_mark_feed_as_read(feeds_ids.first)
    end
  end

  describe '#undo_mark_feeds_as_read' do
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
      .with(body: MultiJson.dump(
              feedIds: feeds_ids.to_ary,
              action: 'undoMarkAsRead',
              type: 'feeds'
      )).to_return(body: '{ }')
      client.undo_mark_feeds_as_read(feeds_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.undo_mark_feeds_as_read(feeds_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#undo_mark_category_as_read' do
    it 'calls undo_mark_categories_as_read' do
      allow(client).to receive(:undo_mark_categories_as_read)
      expect(client).to receive(:undo_mark_categories_as_read)
      .with([categories_ids.first])
      client.undo_mark_category_as_read(categories_ids.first)
    end
  end

  describe '#undo_mark_categories_as_read' do
    it 'sends a post request' do
      stub = stub_request(:post, 'http://sandbox.feedly.com/v3/markers')
      .with(body: MultiJson.dump(
              categoryIds: categories_ids.to_ary,
              action: 'undoMarkAsRead',
              type: 'categories'
      )).to_return(body: '{ }')
      client.undo_mark_categories_as_read(categories_ids)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.undo_mark_categories_as_read(categories_ids)
      expect(subject).to be_a(Feedlr::Success)
    end
  end

  describe '#sync_read_counts' do
    let(:options) { { newerThan: '1400876097' } }
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/markers/reads')
      .with(query: options.to_hash)
      client.sync_read_counts(options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.sync_read_counts(options)
      expect(subject.entries.size).to be > 1
    end
  end

  describe '#lastest_tagged_entries' do
    let(:options) { { newerThan: '1400876097' } }
    it 'sends a get request' do
      stub = stub_request(:get, 'http://sandbox.feedly.com/v3/markers/tags')
      .with(query: options.to_hash)
      client.lastest_tagged_entries(options)
      expect(stub).to have_been_requested
    end

    it 'resoponds with hashie object' do
      subject = client.lastest_tagged_entries(options)
      expect(subject.taggedEntries.size).to be > 1
    end
  end

end
