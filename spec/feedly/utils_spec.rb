require 'helper'
require 'logger'

describe Feedlr::Utils do

  describe '::boolean' do
    it 'should set raise error when values is not boolean' do
      expect { Feedlr::Utils.boolean(5) }.to raise_error(TypeError)
    end

    it 'should return true/false otherwise' do
      expect(Feedlr::Utils.boolean(true)).to eq(true)
      expect(Feedlr::Utils.boolean(false)).to eq(false)
    end
  end

end
