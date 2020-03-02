require_relative 'test_helper'

describe "front desk" do
  it "stores all 20 hotel rooms" do
    expect(Hotel::FrontDesk.rooms.count).must_equal 20
  end
  
end