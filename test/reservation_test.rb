require_relative "test_helper"

describe Hotel::Reservation do
  before do
    @start_date = Date.new(2017, 01, 01)
    @end_date = @start_date + 3
    @reservation = Hotel::Reservation.new(@start_date, @end_date)
  end

  describe "initializes reservation correctly" do

    it "reservation can be succesfully created" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "raises argument error if start date is not at least 1 day before end date" do
      new_start_date = @start_date - 5
      expect{Hotel::Reservation.new(@start_date, new_start_date, @room)}.must_raise ArgumentError
    end

    it "raises argument error if start date is the same as end date" do
      expect{Hotel::Reservation.new(@start_date, @start_date, @room)}.must_raise ArgumentError
    end
    
  end

end