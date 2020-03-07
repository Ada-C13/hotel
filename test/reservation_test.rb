require_relative "test_helper"

describe "Reservation class" do
  before do
    @room_id = 1
    @start_date = "2020-4-1"
    @end_date = "2020-4-5"
    @reservation = Hotel::Reservation.new(room_id: @room_id, start_date: @start_date, end_date: @end_date)
  end

  describe "Reservation instatiation" do
    it "is an instance of reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "has date_range variable which holds an instance of DateRange" do
      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end

    it "has a rate of 200 if no argument provided" do
      expect(@reservation.rate).must_equal 200
    end

    it "can be instantiated with a different rate" do
      reservation = Hotel::Reservation.new(room_id: 2, start_date: "2020-5-1", end_date: "2020-5-6", rate: 210)
      expect(reservation.rate).must_equal 210
    end

    it "zero rate is fine" do
      reservation = Hotel::Reservation.new(room_id: 2, start_date: "2020-5-1", end_date: "2020-5-6", rate: 0)
      expect(reservation.rate).must_equal 0
    end

    it "raises an Argument error if rate provided is invalid (not a number)" do
      expect {
        reservation = Hotel::Reservation.new(room_id: 2, start_date: "2020-5-1", end_date: "2020-5-6", rate: "Cody")
      }.must_raise ArgumentError
    end

    it "raises an Argument error if rate provided is smaller than 0" do
      expect {
        reservation = Hotel::Reservation.new(room_id: 2, start_date: "2020-5-1", end_date: "2020-5-6", rate: -1)
      }.must_raise ArgumentError
    end
  end

  describe "cost" do
    it "returns an integer" do
      expect(@reservation.cost).must_be_kind_of Integer
    end

    it "calculates cost at Reservation's rate" do
      expect(@reservation.cost).must_equal 800

      room_id = 1
      start_date = "2020-5-1"
      end_date = "2020-5-5"
      rate = 180
      reservation = Hotel::Reservation.new(room_id: room_id, start_date: start_date, end_date: end_date, rate: rate)
      expect(reservation.cost).must_equal 720
    end

  end
end