require_relative "test_helper"

describe "Reservation" do

  describe "Initialize" do
  
    before do
      @reservation = Hotel::Reservation.new(start_date: "2020-5-1", end_date: "2020-5-4", num_rooms: 1)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "each start and stop time in array is a Time instance" do
      expect(@reservation.start_date).must_be_kind_of Time
      expect(@reservation.end_date).must_be_kind_of Time
    end

    it "returns an Argument error if given a bad start/end date combination" do
      expect { Hotel::Reservation.new(start_date: "2020-5-5", end_date: "2020-5-4", num_rooms: 1) }.must_raise ArgumentError
    end

    it "returns an Argument error if the start/end date provided are the same" do
      expect { Hotel::Reservation.new(start_date: "2020-5-5", end_date: "2020-5-5", num_rooms: 1) }.must_raise ArgumentError
    end

    it "the number of rooms provided is an Integer" do
      expect(@reservation.num_rooms).must_be_kind_of Integer
    end
  end

  describe "total_cost" do
    before do
      @reservation = Hotel::Reservation.new(start_date: "2020-5-1", end_date: "2020-5-4", num_rooms: 1)
    end

    it "returns the total cost accurately" do
      expect(@reservation.total_cost).must_equal 600.00
    end

    it "returns the total cost as a float" do
      expect(@reservation.total_cost).must_be_kind_of Float
    end
  end
end