require_relative 'test_helper'
require 'date'

describe "Reservations class" do

  describe "Initializer" do
    before do
      check_in = Date.today
      check_out = check_in + 3
      @hotel = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms, blocks: [])
      @reservation = Hotel::Reservations.new(date_in: check_in, date_out: check_out , room_id:1, room: @hotel.rooms[0])
      @hotel.book_a_room(check_in,check_out,@hotel.rooms[0])
    end

    it "tests_overlap" do
      date_in = Date.today
      date_out = date_in + 3
      expect{Hotel::Reservations.new(date_in: date_in ,date_out: date_out ,room_id:1,room: @hotel.rooms[0])}.must_raise ArgumentError
    end

    it "is an instance of Reservations" do      
      expect(@reservation).must_be_kind_of Hotel::Reservations
    end

    it "raises an exception if check in is after check out" do
      date_in = DateTime.new(2020,5,5.5) 
      date_out = DateTime.new(2020,5,3.5)
      expect{Hotel::Reservations.new(date_in: date_in, date_out: date_out, room_id:2)}.must_raise ArgumentError
    end

    it "raises an exception if neither room or room_id is provided" do
      check_in = Date.today
      check_out = check_in + 3
      expect{Hotel::Reservations.new(date_in: check_in, date_out: check_out)}.must_raise ArgumentError
    end

    it "correctly calcutates total numbers of nights spent at hotel per reservation" do
      expect(@reservation.total_number_of_nights_per_reservation).must_equal 3
    end

    it "raises and Argument Error if date out is before date in" do 
      date_in = Date.today + 5
      date_out = Date.today
      expect{Hotel::Reservations.new(date_in: date_in, date_out: date_out , room_id:2, room: @hotel.rooms[0])}.must_raise ArgumentError
    end

  end  
end