require_relative 'test_helper'
require 'date'

describe "Reservations class" do

  describe "Initializer" do
    before do
        @check_in = Date.today
        @check_out = @check_in + 3
        @check_in1 = Date.today + 5
        @check_out1 = Date.today
        @hotel = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms)
        @reservation = Hotel::Reservations.new(date_in: @check_in, date_out: @check_out , room_id:1, room: @hotel.rooms[0])
      end

    it "is an instance of Reservations" do      
        expect(@reservation).must_be_kind_of Hotel::Reservations
    end

    it "raises an exception if check in is after check out" do
        check_in = Date.today +7
        check_out = @check_in - 4
        expect{Hotel::Reservations.new(date_in: check_in, date_out: check_out, room_id:2)}.must_raise ArgumentError
    end


    it "raises an exception if neither room or room_id is provided" do
        check_in = Date.today
        check_out = @check_in + 3
        expect{Hotel::Reservations.new(date_in: check_in, date_out: check_out)}.must_raise ArgumentError
    end

    it "correctly calcutates total numbers of nights spent at hotel per reservation" do
       expect(@reservation.total_number_of_nights_per_reservation).must_equal 3
    end

    it "raises and Argument Error if date out is before date in" do 
        expect{Hotel::Reservations.new(date_in: @check_in1, date_out: @check_out1 , room_id:2)}.must_raise ArgumentError
    end
    

  end  
end