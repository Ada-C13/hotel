require_relative "test_helper"

describe "dummy tests" do 
  it "should run a failed test" do 
    _(true).must_equal false
  end

  it "should be able to access data from room.rb" do 
    _(CONSTANT).must_equal 24
  end 
end 