require_relative 'test_helper'

describe "rooms" do

  describe "initializing room" do
    before do
      @room = Hotel::Room.new(room_number: 1, cost: 200)
    end

    it "creates an instance of a room" do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it "raises an ArgumentError if status is not available or unavailable" do
      expect{Hotel::Room.new(room_number: 1, cost: 200, status: "xyz")}.must_raise ArgumentError
    end
  end
end