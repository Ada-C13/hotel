require_relative "test_helper"

describe "Hotel::Reservation" do
  describe "constructor" do
    it "can be initialized with two dates and a room" do
      start_date = Date.new(2017, 01, 01)
      end_date   = start_date + 3
      room = 10
      reservation = Hotel::Reservation.new(start_date, end_date, room)

      expect(reservation).must_be_kind_of Hotel::Reservation
      expect(reservation.range.start_date).must_equal start_date
      expect(reservation.range.end_date).must_equal end_date
      expect(reservation.room).must_equal room
    end

    it "raises an ArgumentError if invalid dates provided" do
      start_date = Date.new(2017, 01, 01)
      end_date1   = start_date - 1
      end_date2   = "2017/01/04"
      room = 10

      # start date can not be after end date
      expect{ reservation = Hotel::Reservation.new(start_date, end_date1, room) }.must_raise ArgumentError
      # date can not be a string
      expect{ reservation = Hotel::Reservation.new(start_date, end_date2, room) }.must_raise ArgumentError
      # start date can not be the same as end date
      expect{ reservation = Hotel::Reservation.new(start_date, start_date, room) }.must_raise ArgumentError
    end
  end

  describe "cost" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date   = start_date + 3
      room = 10
      @reservation = Hotel::Reservation.new(start_date, end_date, room)
    end

    it "returns a number" do
      expect(@reservation.cost).must_be_kind_of Numeric
    end

    it "calculates the cost" do
      # Reservation - Every room is identical and a room always costs $200/night
      expect(@reservation.cost).must_equal 600
    end

  end
end

# User Stories - As a user of the hotel system...I can/want to...so that I can/can't

# HotelController - access the list of all of the rooms in the hotel "Who has the list of all the rooms in the hotel?"
# HotelController - access the list of reservations for a specified room and a given date range "Who has access to that?"
# HotelController - access the list of reservations for a specific date, so that I can track reservations by date
# Reservation     - get the total cost for a given reservation
# DateRange       - want exception raised when an invalid date range is provided, so I can't make a reservation for an invalid date range

# Details

# HotelController - the hotel has 20 rooms, numbered 1 through 20 (array from 1 to 20)
# Reservation     - every room is identical and costs $200/night (constant cost $200)
# DateRange       - last day is the checkout day, guest shouldn't be charged for that day/night (end_day doesn't count)
# HotelController - given only start and end dates, determine which room to use for the reservation

# For this wave, you don't need to check whether reservations conflict with each other (this will come in wave 2!)