require 'helper'

describe Feedlr::Base do

  describe '#is_a?' do
    it 'should be subclass of Hashie::Mash' do
      expect(Feedlr::Base.new(a: 1)).to be_a(Hashie::Mash)
    end
  end
end
