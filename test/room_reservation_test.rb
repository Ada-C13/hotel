require_relative "test_helper"

describe Hotel::RoomReservation do
  before do
    @start_date = Date.new(2017, 01, 01)
    @end_date = @start_date + 3
    @room = Hotel::Room.new(10,cost:450)
    @room_reservation = Hotel::RoomReservation.new(@start_date, @end_date, @room)
  end

  describe "initializes reservation correctly" do

    it "reservation can be succesfully created" do
      expect(@room_reservation).must_be_kind_of Hotel::RoomReservation
    end

    it "instance variables can be succesfully read" do
      expect(@room_reservation.start_date).must_equal @start_date
      expect(@room_reservation.end_date).must_equal @end_date
      expect(@room_reservation.room).must_equal @room
      expect(@room_reservation.date_range).must_be_kind_of Hotel::DateRange

    end

    it "raises argument error if start date is not at least 1 day before end date" do
      new_start_date = @start_date - 5
      expect{Hotel::RoomReservation.new(@start_date, new_start_date, @room)}.must_raise ArgumentError
    end

    it "raises argument error if start date is the same as end date" do
      expect{Hotel::RoomReservation.new(@start_date, @start_date, @room)}.must_raise ArgumentError
    end

    it "raises argument error if room is not an instance of Hotel::Room" do
      rm_number = 5
      expect{Hotel::RoomReservation.new(@start_date, @end_date, rm_number)}.must_raise ArgumentError
    end
  end

  describe "cost" do

    it "returns a number" do
      expect(@room_reservation.cost).must_be_kind_of Numeric
    end

    it "calculates the correct cost of a reservation" do
      expect(@room_reservation.cost).must_equal 1350
    end
    
  end
end