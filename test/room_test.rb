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
  end

  # # PRIVATE METHODS
  #   describe "new_reservation" do
  #     it "creates a new reservation" do
  #       room = Hotel::Room.new(5)
  #       result = room.new_reservation(room_id: room.id, start_date: "2020-3-1", end_date: "2020-3-10")
  #       expect(result).must_be_kind_of Hotel:: Reservation
  #       expect(result.room_id).must_equal 5
  #     end
  #   end
  # end
end