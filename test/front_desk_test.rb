require_relative 'test_helper'
require 'date'

describe "FrontDesk" do
  describe "#initialize" do
    it "Creates an instance of FrontDesk" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk).must_be_kind_of Hotel::FrontDesk
    end

    it "Keeps track of rooms" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk).must_respond_to :rooms
    end

    it "Keeps track of reservations" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk).must_respond_to :reservations
    end

    it "Creates an array of rooms 1 through 20" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.rooms).must_be_kind_of Array
      expect(front_desk.rooms.length).must_equal 20

      front_desk.rooms.each do |room|
        expect(room).must_be_kind_of Integer
      end

      expect(front_desk.rooms.first).must_equal 1
      expect(front_desk.rooms.last).must_equal 20
    end

    it "Creates an empty array of reservations" do
      front_desk = Hotel::FrontDesk.new
      expect(front_desk.reservations).must_be_kind_of Array
      expect(front_desk.reservations.length).must_equal 0
    end
  end

  describe "#make_reservation" do
    it "raises ArgumentError for passing invalid arguments" do
      front_desk = Hotel::FrontDesk.new
      expect{
        front_desk.make_reservation("2020, 2, 12", Date.new(2020, 5, 1))
      }.must_raise ArgumentError
      
    end

    it "makes reservation" do 
      front_desk = Hotel::FrontDesk.new
      made_reservation = front_desk.make_reservation(Date.new(2020, 5, 1), Date.new(2020, 5, 4))
      expect(made_reservation.last).must_be_kind_of Hotel::Reservation
      expect(made_reservation.last.date_range.start_date).must_equal Date.new(2020, 5, 1)
      expect(made_reservation.last.date_range.end_date).must_equal Date.new(2020, 5, 4)

    end

    it "adds a newly created reservation to the reservations list" do
      front_desk = Hotel::FrontDesk.new
      reservations_before = front_desk.reservations.length
      puts "before length = #{reservations_before}"
      made_reservation = front_desk.make_reservation(Date.new(2020, 5, 5), Date.new(2020, 5, 8))
      reservations_after = front_desk.reservations.length
      puts "after length = #{reservations_after}"
      expect(reservations_after).must_equal (reservations_before + 1)
    end
  end

  describe "#reservations_by_room" do
    it "returns reservation(s) for a particular room" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 1), Date.new(2020, 3, 5))
      front_desk.make_reservation(Date.new(2020, 3, 5), Date.new(2020, 3, 8))
      front_desk.make_reservation(Date.new(2020, 3, 9), Date.new(2020, 3, 12))

      room_reservations = front_desk.reservations_by_room(1)
      expect(room_reservations).must_be_kind_of Array
      expect(room_reservations.length).must_equal 3
      room_reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
        expect(reservation.room).must_equal 1
      end
    end

    it "returns an empty array if no reservations made for a room" do
      front_desk = Hotel::FrontDesk.new
      room_reservations = front_desk.reservations_by_room(1)
      expect(room_reservations).must_be_kind_of Array
      expect(room_reservations.length).must_equal 0
    end

    it "raises ArgumnetError for passing an invalid argument" do
      front_desk = Hotel::FrontDesk.new
      expect{
        front_desk.reservations_by_room("five")
      }.must_raise ArgumentError
    end
  end

  describe "#reservations_by_start_date" do
    it "returns reservations for a particular date" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 12))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 15))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 11))

      date_reservations = front_desk.reservations_by_start_date(Date.new(2020, 3, 10))
      expect(date_reservations).must_be_kind_of Array
      expect(date_reservations.length).must_equal 4
      date_reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
        expect(reservation.date_range.start_date).must_equal Date.new(2020, 3, 10)
      end
    end

    it "returns an empty array if no reservations made for that date" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 12))
      date_reservations = front_desk.reservations_by_start_date(Date.new(2020, 3, 13))
      expect(date_reservations).must_be_kind_of Array
      expect(date_reservations.length).must_equal 0
    end

    it "raises ArgumentError for passing an invalid argument" do
      front_desk = Hotel::FrontDesk.new
      expect{
        front_desk.reservations_by_start_date("2020, 3, 4")
      }.must_raise ArgumentError
    end
  end

  describe "#reservations_by_date_range" do
    it "returns reservations for a particular date range" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      front_desk.make_reservation(Date.new(2020, 3, 12), Date.new(2020, 3, 15))
      reservations_for_date_range = front_desk.reservations_by_date_range(Date.new(2020, 3, 10), Date.new(2020, 3, 14))

      expect(reservations_for_date_range).must_be_kind_of Array
      expect(reservations_for_date_range.length).must_equal 2
    end

    it "returns an empty array if no reservations made for that date range" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      front_desk.make_reservation(Date.new(2020, 3, 12), Date.new(2020, 3, 15))
      reservations_for_date_range = front_desk.reservations_by_date_range(Date.new(2020, 3, 12), Date.new(2020, 3, 13))

      expect(reservations_for_date_range).must_be_kind_of Array
      expect(reservations_for_date_range.length).must_equal 0
    end
  end

  describe "#reservations_by_room_and_date_range" do
    it "returns reservations for a given room and date range" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 20), Date.new(2020, 3, 24))
      front_desk.make_reservation(Date.new(2020, 3, 25), Date.new(2020, 3, 28))
      front_desk.make_reservation(Date.new(2020, 3, 20), Date.new(2020, 3, 24))

      reservations = front_desk.reservations_by_room_and_date_range(Date.new(2020, 3, 20), Date.new(2020, 3, 24), 1)
      expect(reservations).must_be_kind_of Array
      expect(reservations.length).must_equal 1
      expect(reservations[0].date_range.start_date).must_equal Date.new(2020, 3, 20)
      expect(reservations[0].date_range.end_date).must_equal Date.new(2020, 3, 24)
      expect(reservations[0].room).must_equal 1
    end

    it "returns an empty array if no reservations match the criteria" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 20), Date.new(2020, 3, 24))
      front_desk.make_reservation(Date.new(2020, 3, 25), Date.new(2020, 3, 28))

      reservations = front_desk.reservations_by_room_and_date_range(Date.new(2020, 3, 25), Date.new(2020, 3, 28), 2)
      expect(reservations).must_be_kind_of Array
      expect(reservations.length).must_equal 0
    end
  end

  describe "#available_rooms_for" do
    it "returns a list of rooms that are not reserved for a given date range" do
      front_desk = Hotel::FrontDesk.new
      5.times do
        front_desk.make_reservation(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      end

      given_date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      unreserved_rooms = front_desk.available_rooms_for(given_date_range)

      expect(unreserved_rooms).must_be_kind_of Array
      expect(unreserved_rooms.length).must_equal 15
      expect(unreserved_rooms[0]).must_equal 6
      expect(unreserved_rooms[-1]).must_equal 20
      unreserved_rooms.each do |room|
        expect(room).must_be_kind_of Integer
      end

    end

    it "returns all rooms if there are no reservations made for that date range" do
      front_desk = Hotel::FrontDesk.new
      5.times do
        front_desk.make_reservation(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      end

      given_date_range = Hotel::DateRange.new(Date.new(2020, 5, 10), Date.new(2020, 5, 12))
      unreserved_rooms = front_desk.available_rooms_for(given_date_range)
      expect(unreserved_rooms).must_be_kind_of Array
      expect(unreserved_rooms.length).must_equal 20
    end

    it "returns empty array if all rooms are reserved for that date range" do
      front_desk = Hotel::FrontDesk.new
      20.times do
        front_desk.make_reservation(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      end

      given_date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 15))

      unreserved_rooms = front_desk.available_rooms_for(given_date_range)
      expect(unreserved_rooms.length).must_equal 0
    end
  end

  describe "#make_block" do
    default_discount = 50

    before do
      @front_desk = Hotel::FrontDesk.new
      @default_date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 15))
    end
    
    it "Raises exception when number of rooms is invalid" do
      expect {
        @front_desk.make_block(@default_date_range, 6, default_discount)
      }.must_raise ArgumentError

      expect {
        @front_desk.make_block(@default_date_range, -1, default_discount)
      }.must_raise ArgumentError
    end

    it "Raises exception when number of rooms is greater than available rooms" do
      18.times do
        @front_desk.make_reservation(@default_date_range.start_date, @default_date_range.end_date)
      end

      expect{
        @front_desk.make_reservation(@default_date_range, 3, default_discount)
      }.must_raise ArgumentError
    end

    it "Creates blocks successfully when all arguments are valid" do
      first_block_id = @front_desk.make_block(@default_date_range, 3, default_discount)
      second_block_id = @front_desk.make_block(@default_date_range, 4, default_discount)
      expect(@front_desk.blocks).must_be_kind_of Hash
      expect(@front_desk.blocks.length).must_equal 2
      expect(@front_desk.blocks[first_block_id].room_collection.length).must_equal 3
      expect(@front_desk.blocks[second_block_id].room_collection.length).must_equal 4
    end
  end

  describe "#create_reservation_for_block" do
    default_discount = 50

    before do
      @front_desk = Hotel::FrontDesk.new
      @default_date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 15))
    end

    it "Raises exception when block id is not present in blocks" do
      expect{
        @front_desk.create_reservation_for_block("twyutr456", 12)
      }.must_raise ArgumentError
    end

    it "Raises exception if a given room is not present in the block" do
      block_id = @front_desk.make_block(@default_date_range, 4, default_discount)
      expect{
        @front_desk.create_reservation_for_block(block_id, 20)
      }.must_raise ArgumentError
    end

    it "Creates block reservation sucessfully when all arguments are valid" do 
      block_id = @front_desk.make_block(@default_date_range, 4, default_discount)
      reservations_before = @front_desk.reservations.length
      @front_desk.create_reservation_for_block(block_id, 4)
      reservations_after = @front_desk.reservations.length
      expect(reservations_before + 1).must_equal reservations_after
    end

    it "Raises exception if room is already reserved" do
      block_id = @front_desk.make_block(@default_date_range, 4, default_discount)
      @front_desk.create_reservation_for_block(block_id, 4)
      expect{
        @front_desk.create_reservation_for_block(block_id, 4)
      }.must_raise ArgumentError
    end
  end
end
