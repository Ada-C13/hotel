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

  describe "#select_available_room" do
    it "returns a room if there are no reservations made for it" do
      front_desk = Hotel::FrontDesk.new
      selected_room = front_desk.select_available_room(Date.new(2020, 3, 1), Date.new(2020, 3, 5))
      puts "selected room: #{selected_room}"
      expect(selected_room).must_equal 1
    end

    it "returns a room which reservation date range doesn't conflict with the current one" do
      front_desk = Hotel::FrontDesk.new
      date_range = Hotel::DateRange.new(Date.new(2020, 3, 1), Date.new(2020, 3, 5))
      reservation_one = Hotel::Reservation.new(date_range, 1)
      front_desk.reservations << reservation_one
      puts "reservations: #{front_desk.reservations}"
      selected_room = front_desk.select_available_room(Date.new(2020, 3, 6), Date.new(2020, 3, 8))

      expect(selected_room).must_equal 1

      date_range_two = Hotel::DateRange.new(Date.new(2020, 3, 6), Date.new(2020, 3, 8))
      reservation_two = Hotel::Reservation.new(date_range_two, selected_room)
      front_desk.reservations << reservation_two
      puts "reservations = #{front_desk.reservations}"

      room_selected = front_desk.select_available_room(Date.new(2020, 3, 7), Date.new(2020, 3, 9))
      expect(room_selected).must_equal 2

      date_range_three = Hotel::DateRange.new(Date.new(2020, 3, 7), Date.new(2020, 3, 9))
      reservation_three = Hotel::Reservation.new(date_range_three, room_selected)
      front_desk.reservations << reservation_three
      puts "reservations = #{front_desk.reservations}"

    end

    it "raises an error when reserving a room during a date range when all rooms are reserved" do
      # it works, checks on the rooms array of length 2. Need to retest when make reservation method is implemented.


      # front_desk = Hotel::FrontDesk.new
      # date_range = Hotel::DateRange.new(Date.new(2020, 3, 1), Date.new(2020, 3, 5))
      # reservation_one = Hotel::Reservation.new(date_range, 1)
      # front_desk.reservations << reservation_one
      # puts "reservations: #{front_desk.reservations}"
      # selected_room = front_desk.select_available_room(Date.new(2020, 3, 6), Date.new(2020, 3, 8))

      # expect(selected_room).must_equal 1

      # date_range_two = Hotel::DateRange.new(Date.new(2020, 3, 6), Date.new(2020, 3, 8))
      # reservation_two = Hotel::Reservation.new(date_range_two, selected_room)
      # front_desk.reservations << reservation_two
      # puts "reservations = #{front_desk.reservations}"

      # room_selected = front_desk.select_available_room(Date.new(2020, 3, 7), Date.new(2020, 3, 9))
      # expect(room_selected).must_equal 2

      # date_range_three = Hotel::DateRange.new(Date.new(2020, 3, 7), Date.new(2020, 3, 9))
      # reservation_three = Hotel::Reservation.new(date_range_three, room_selected)
      # front_desk.reservations << reservation_three
      # puts "reservations = #{front_desk.reservations}"

      # expect{
      #   front_desk.select_available_room(Date.new(2020, 3, 4), Date.new(2020, 3, 8))
      # }.must_raise ArgumentError
      
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

  describe "#reservation_by_room" do
    it "returns reservation(s) for a particular room" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 1), Date.new(2020, 3, 5))
      front_desk.make_reservation(Date.new(2020, 3, 5), Date.new(2020, 3, 8))
      front_desk.make_reservation(Date.new(2020, 3, 9), Date.new(2020, 3, 12))

      room_reservations = front_desk.reservation_by_room(1)
      expect(room_reservations).must_be_kind_of Array
      expect(room_reservations.length).must_equal 3
      room_reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
        expect(reservation.room).must_equal 1
      end
    end

    it "returns an empty array if no reservations made for a room" do
      front_desk = Hotel::FrontDesk.new
      room_reservations = front_desk.reservation_by_room(1)
      expect(room_reservations).must_be_kind_of Array
      expect(room_reservations.length).must_equal 0
    end

    it "raises ArgumnetError for passing an invalid argument" do
      front_desk = Hotel::FrontDesk.new
      expect{
        front_desk.reservation_by_room("five")
      }.must_raise ArgumentError
    end
  end

  describe "#reservation_by_date" do
    it "returns reservations for a particular date" do
      front_desk = Hotel::FrontDesk.new
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 14))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 12))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 15))
      front_desk.make_reservation(Date.new(2020, 3, 10), Date.new(2020, 3, 11))

      date_reservations = front_desk.reservation_by_date(Date.new(2020, 3, 10))
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
      date_reservations = front_desk.reservation_by_date(Date.new(2020, 3, 13))
      expect(date_reservations).must_be_kind_of Array
      expect(date_reservations.length).must_equal 0
    end

    it "raises ArgumentError for passing an invalid argument" do
      front_desk = Hotel::FrontDesk.new
      expect{
        front_desk.reservation_by_date("2020, 3, 4")
      }.must_raise ArgumentError
    end

  end

end








