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
  end

  describe "cost" do
    it "returns an integer" do
      expect(@reservation.cost).must_be_kind_of Integer
    end

    it "calculates cost as $200/night" do
      expect(@reservation.cost).must_equal 800
    end
  end
end