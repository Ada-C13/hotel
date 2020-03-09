require_relative 'test_helper'

describe "Room Class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(1)
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "stores an id" do
      expect(@room.id).must_equal 1
    end

    it "starts with an empty array for reservations" do
      expect(@room.reservations).must_be_kind_of Array
      expect(@room.reservations.empty?).must_equal true
    end

    it "starts with an empty array for block participation" do
      expect(@room.block_participation).must_be_kind_of Array
      expect(@room.block_participation.empty?).must_equal true
    end
  end

  describe "reserved?" do
    before do
      @room = Hotel::Room.new(1)
      @room.reserve(start_date: "2020-3-1", end_date: "2020-3-10")
    end

    it "returns true if the room is reserved for requested dates" do
      expect(@room.reserved?(start_date: "2020-3-2", end_date: "2020-3-25")).must_equal true
    end

    it "returns false if the room is not reserved for requested dates" do
      expect(@room.reserved?(start_date: "2020-3-22", end_date: "2020-3-25")).must_equal false
    end
  end

  describe "in_block?" do
    before do
      @room = Hotel::Room.new(1)
      @room.reserve(start_date: "2020-3-1", end_date: "2020-3-10", block: 2)
    end

    it "returns true if the room is in a block for requested dates" do
      expect(@room.in_block?(start_date: "2020-3-2", end_date: "2020-3-25")).must_equal true
    end

    it "returns false if the room is not in a block for requested dates" do
      expect(@room.in_block?(start_date: "2020-3-22", end_date: "2020-3-25")).must_equal false
    end
  end

  describe "available?" do
    before do
      @room = Hotel::Room.new(1)
      @room.reserve(start_date: "2020-3-1", end_date: "2020-3-10")
    end

    it "returns true if the room is available for requested dates" do
      expect(@room.available?(start_date: "2020-3-22", end_date: "2020-3-25")).must_equal true
    end

    it "returns false if the room is unavailable for requested dates" do
      expect(@room.available?(start_date: "2020-3-2", end_date: "2020-3-5")).must_equal false
    end
  end

  describe "reserve" do
    it "creates a new reservation and add it to the Room's reservations array" do
      @room = Hotel::Room.new(10)
      @room.reserve(start_date: "2020-3-1", end_date: "2020-3-10")
      expect(@room.reservations.length).must_equal 1
      expect(@room.reservations[0]).must_be_kind_of Hotel::Reservation
      expect(@room.reservations[0].room_id).must_equal 10
    end

    it "reserves a room at default rate if no other specified" do
      room = Hotel::Room.new(10)
      room.reserve(start_date: "2020-3-1", end_date: "2020-3-10")
      rate = room.reservations[0].rate
      expect(rate).must_equal 200
    end

    it "reserves room at a specified rate" do
      room = Hotel::Room.new(10)
      room.reserve(start_date: "2020-3-1", end_date: "2020-3-10", rate: 339.99)
      rate = room.reservations[0].rate
      expect(rate).must_equal 339.99
    end
  end

  describe "select_reservations" do
    before do
      @room = Hotel::Room.new(10)
      @room.reserve(start_date: "2020-3-1", end_date: "2020-3-10")
      @room.reserve(start_date: "2020-3-12", end_date: "2020-3-13")
      @room.reserve(start_date: "2020-3-15", end_date: "2020-3-20")
      
    end
    it "returnes reservations which match requested date range" do
      date_range = Hotel::DateRange.new(start_date: "2020-3-1", end_date: "2020-3-25")
      expect(@room.select_reservations(date_range).length).must_equal 3
    end

    it "returns empty array if no reservations were made for requested dates" do
      date_range = Hotel::DateRange.new(start_date: "2020-4-1", end_date: "2020-4-25")
      expect(@room.select_reservations(date_range).empty?).must_equal true
    end
  end
end

