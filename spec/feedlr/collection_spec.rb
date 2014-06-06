require 'helper'

describe Feedlr::Collection do

  describe '::new' do
    it 'should have empty data when initialized with no data' do
      collection = Feedlr::Collection.new
      expect(collection.first).to be_nil
    end

    it 'should have Feedlr::Base elements when the elements are hashes' do
      collection = Feedlr::Collection.new([{ a: 1 }, { b: 2 }])
      expect(collection.first).to be_a(Feedlr::Base)
    end
    it 'should have normal elements when the elements are not hashes' do
      collection = Feedlr::Collection.new([1, { z: 5 }])
      expect(collection.first).to be_a(Integer)
    end
  end
end
