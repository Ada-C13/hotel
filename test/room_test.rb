require_relative "test_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new(room_num: 1, cost: 200, reserved_dates: 01 / 01 / 21)
  end

  it "is an instance of Room" do
    expect(@room).must_be_kind_of Hotel::Room
  end
end
