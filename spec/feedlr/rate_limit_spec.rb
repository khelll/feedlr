require 'helper'

describe Feedlr::RateLimit do
  describe '#count' do
    it 'returns an Integer when x-ratelimit-count header is set' do
      rate_limit = Feedlr::RateLimit.new('x-ratelimit-count' => '149')
      expect(rate_limit.count).to be_an Integer
      expect(rate_limit.count).to eq(149)
    end
    it 'returns nil when x-ratelimit-count header is not set' do
      rate_limit = Feedlr::RateLimit.new
      expect(rate_limit.count).to be_nil
    end
  end

  describe '#limit' do
    it 'returns an Integer when x-ratelimit-limit header is set' do
      rate_limit = Feedlr::RateLimit.new('x-ratelimit-limit' => '150')
      expect(rate_limit.limit).to be_an Integer
      expect(rate_limit.limit).to eq(150)
    end
    it 'returns nil when x-ratelimit-limit header is not set' do
      rate_limit = Feedlr::RateLimit.new
      expect(rate_limit.limit).to be_nil
    end
  end

  describe '#remaining' do
    it 'returns an Integer when x-ratelimit-remaining header is set' do
      rate_limit = Feedlr::RateLimit.new('x-ratelimit-remaining' => '149')
      expect(rate_limit.remaining).to be_an Integer
      expect(rate_limit.remaining).to eq(149)
    end
    it 'returns nil when x-ratelimit-remaining header is not set' do
      rate_limit = Feedlr::RateLimit.new
      expect(rate_limit.remaining).to be_nil
    end
  end
end
