require 'simplecov'
SimpleCov.start

require_relative "test_helper"

describe "Reservation" do

  describe "Initialize" do
  
    before do
      @reservation = Hotel::Reservation.new(start_date: Date.new(2020, 5, 1), end_date: Date.new(2020, 5, 4), num_rooms: 1)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "each start and stop time in array is a Time instance" do
      expect(@reservation.start_date).must_be_kind_of Date
      expect(@reservation.end_date).must_be_kind_of Date
    end

    it "the number of rooms provided is an Integer" do
      expect(@reservation.num_rooms).must_be_kind_of Integer
    end
    
    it "returns an ArgumentError if given a bad start/end date combination" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 4), num_rooms: 1) }.must_raise ArgumentError
    end

    it "returns an ArgumentError if the start/end date provided are the same" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 5), num_rooms: 1) }.must_raise ArgumentError
    end

    it "raises an ArgumentError rooms given is not an Integer" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: "B") }.must_raise ArgumentError
    end

    it "raises an ArgumentError room assigned is not nil when reservation is created" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: 1, assigned_room: 4) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if more than 5 rooms are requested" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: 6) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if an invalid reservation status is given for block" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: 5, block: :BANANA) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if block is noted but only one room is requested" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: 1, block: :BLOCK) }.must_raise ArgumentError
    end

    xit "raises an ArgumentError if block_key is not a string" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: 2, block_key: 7) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if a block_key is given for a single room" do
      expect { Hotel::Reservation.new(start_date: Date.new(2020, 5, 5), end_date: Date.new(2020, 5, 6), num_rooms: 1, block_key: 7) }.must_raise ArgumentError
    end
  end

  describe "total_cost" do
    before do
      @reservation = Hotel::Reservation.new(start_date: Date.new(2020, 5, 1), end_date: Date.new(2020, 5, 4), num_rooms: 1)
    end
    
    it "returns the total cost accurately for a single room" do
      expect(@reservation.total_cost).must_equal 600.00
    end

    it "returns the total cost as a float" do
      expect(@reservation.total_cost).must_be_kind_of Float
    end    
  end

  describe "total_cost block" do
    before do
      @reservation = Hotel::Reservation.new(start_date: Date.new(2020, 5, 1), end_date: Date.new(2020, 5, 4), num_rooms: 3, discount: 0.10, block: :BLOCK)
    end
    
    it "returns the total cost as a float" do
      expect(@reservation.total_cost).must_be_kind_of Float
    end
    
    it "returns the total cost accurately for room blocks (includes discount)" do
      expect(@reservation.total_cost).must_equal 1620.00
    end
  end
end