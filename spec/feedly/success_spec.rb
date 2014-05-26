require 'helper'

describe Feedlr::Success do
  it 'should be an embty Feedlr::Base' do
    expect(Feedlr::Success.new).to eql(Feedlr::Base.new({}))
  end
end
