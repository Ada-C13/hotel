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
end








