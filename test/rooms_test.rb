require_relative 'test_helper'

describe "rooms" do
  describe "initializing room" do
    it "creates an instance of a room" do
      room = Hotel::Room.new(room_number: 1, cost: 200)
      expect(room).must_be_instance_of Hotel::Room
    end

    it "raises an ArgumentError if status is not available or unavailable" do
      
    end
  end
end