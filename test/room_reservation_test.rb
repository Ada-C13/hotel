require_relative "test_helper"

describe Hotel::RoomReservation do
  before do
    @start_date = Date.new(2017, 01, 01)
    @end_date = @start_date + 3
    @room = Hotel::Room.new(10,cost:450)
    @reservation = Hotel::RoomReservation.new(@start_date, @end_date, @room)
  end

  describe "initializes reservation correctly" do

    it "reservation can be succesfully created" do
      expect(@reservation).must_be_kind_of Hotel::RoomReservation
    end

    it "raises argument error if start date is not at least 1 day before end date" do
      new_start_date = @start_date - 5
      expect{Hotel::RoomReservation.new(@start_date, new_start_date, @room)}.must_raise ArgumentError
    end

    it "raises argument error if start date is the same as end date" do
      expect{Hotel::RoomReservation.new(@start_date, @start_date, @room)}.must_raise ArgumentError
    end
    
  end

  describe "cost" do

    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end

    it "calculates the correct cost of a reservation" do
      expect(@reservation.cost).must_equal 1350
    end

  end

end