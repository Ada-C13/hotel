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
