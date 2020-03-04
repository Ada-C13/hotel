require_relative "test_helper"

describe Hotel::Room do
  describe "initialize a room" do
    it "properly initializes a room" do
      new_room = Hotel::Room.new(5)
      expect(new_room).must_be_kind_of Hotel::Room
    end

    it "raises an argument error if a non-integer is used as an argument when initializing a room object" do
      expect{Hotel::Room.new("hello")}.must_raise ArgumentError
      expect{Hotel::Room.new(1.0)}.must_raise ArgumentError
    end

    it "raises and argument error if no arguments are given" do
      expect{Hotel::Room.new}.must_raise ArgumentError
    end
  end
  
  describe "able to read room_number and cost for a room object" do
    before do
      @new_room = Hotel::Room.new(5, cost: 500)
    end

    it "able to read the room number" do
      expect(@new_room.room_number).must_equal 5
    end

    it "able to read the room cost" do
      expect(@new_room.cost).must_equal 500
    end
  end
end