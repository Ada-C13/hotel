require_relative 'test_helper'

describe "Room class" do
  describe "#initialize" do
    it "creates an instance of Room class" do
      room = Hotel::Room.new(1)
      expect(room).must_be_instance_of Hotel::Room
    end

    it "keeps track of a room number" do
      number = 20
      room = Hotel::Room.new(number)
      expect(room.number).must_equal number
    end

    it "raises an Argument Error if a room number is out of range" do
      number = 21
      expect{Hotel::Room.new(number)}.must_raise ArgumentError
      
      number = 0
      expect{Hotel::Room.new(number)}.must_raise ArgumentError
    end
  end
end
