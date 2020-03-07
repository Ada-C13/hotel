require_relative 'test_helper'

describe "HotelBlock class" do
  describe "#initialize" do
    it "creates an instance of a HotelBlock class" do
      range = Hotel::DateRange.new(start_date: "2 Mar 2020", end_date: "5 Mar 2020")
      block = Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), Hotel::Room.new(2)],
        date_range: range,
        discounted_rate: 150)
      expect(block).must_be_instance_of Hotel::HotelBlock
    end

    it "calculates the cost of reservation, does not count the last day" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")
      block = Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), Hotel::Room.new(2)],
        date_range: range,
        discounted_rate: 150)
      expect(block.cost).must_equal 600
    end

    it "raises an ArgumentError when trying to book more than 5 rooms in a block" do
      range = Hotel::DateRange.new(start_date: "3 Mar 2020", end_date: "5 Mar 2020")
      expect{Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), 
          Hotel::Room.new(2), 
          Hotel::Room.new(3), 
          Hotel::Room.new(4), 
          Hotel::Room.new(5), 
          Hotel::Room.new(6)],
        date_range: range,
        discounted_rate: 150)}.must_raise ArgumentError
    end
  end

  describe "#book_room" do
    it "returns an array of rooms" do
      range = Hotel::DateRange.new(start_date: "2 Mar 2020", end_date: "5 Mar 2020")
      block = Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), Hotel::Room.new(2)],
        date_range: range,
        discounted_rate: 150)
      reserving = block.book_room(Hotel::Room.new(2))
      expect(reserving).must_be_instance_of Array
      expect(block.reserved_rooms.first).must_be_instance_of Hotel::Room
    end

    it "moves a specific room to reserved_rooms array" do
      range = Hotel::DateRange.new(start_date: "2 Mar 2020", end_date: "5 Mar 2020")
      block = Hotel::HotelBlock.new(
        rooms: [Hotel::Room.new(1), Hotel::Room.new(2)],
        date_range: range,
        discounted_rate: 150)
      reserving = block.book_room(Hotel::Room.new(2))
      expect(block.reserved_rooms.first.number).must_equal 2
    end
  end
end
