require 'helper'

describe Feedlr::Mapper do
  describe 'Mapper.build' do
    it 'returns Feedlr::Base object when the input is a non empty hash' do
      obj = { a: 1 , b: 2 }
      expect(Feedlr::Mapper.build(obj)).to eq(Feedlr::Base.new(obj))
    end
    it 'returns Feedlr::Collection object when the input is an array' do
      obj = [{ a: 1 , b: 2 } , { c: 3 ,  d: 4 }]
      expect(Feedlr::Mapper.build(obj)).to eq(Feedlr::Collection.new(obj))
    end

    it 'returns Feedlr::Success object if input is an empty hash' do
      obj = {}
      expect(Feedlr::Mapper.build(obj)).to eq(Feedlr::Success.new)
    end

    it "returns Feedlr::Success object if input is not \
    Hash with content or Array" do
      obj = 5
      expect(Feedlr::Mapper.build(obj)).to eq(Feedlr::Success.new)
    end
  end
end
