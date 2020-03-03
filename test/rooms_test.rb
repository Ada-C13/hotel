require_relative 'test_helper'

describe "rooms" do

  describe "initializing room" do
    before do
      @room = Hotel::Room.new(room_number: 1, cost: 200)
    end

    it "creates an instance of a room" do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it "raises an arguement error if room number is less than 1 or more than 20" do
      expect{Hotel::Room.new(room_number: 21, cost: 200)}.must_raise ArgumentError
      expect{Hotel::Room.new(room_number: -1, cost: 200)}.must_raise ArgumentError
    end
  end
end