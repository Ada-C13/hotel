require_relative "test_helper"

describe "Reservation" do
  before do
    daterange = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))

    @reservation = Hotel::Reservation.new(daterange)
  end

  describe "initialize" do
    it "creates an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
      expect(@reservation).must_respond_to :start_date
      expect(@reservation).must_respond_to :end_date
      expect(@reservation).must_respond_to :nights
      expect(@reservation).must_respond_to :total_cost
      expect(@reservation).must_respond_to :id
      expect(@reservation).must_respond_to :room_number
    end

    it "determines total number of nights correctly" do
      expect(@reservation.nights).must_equal 2
    end
  end
end