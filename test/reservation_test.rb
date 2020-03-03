require_relative 'test_helper'

describe "Reservation" do
  describe "#initialize" do
    it "Creates an instance of Reservation" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      reservation = Hotel::Reservation.new(date_range, 10)
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of date range" do
      start_date = Date.new(2020, 3, 1)
      end_date = Date.new(2020, 3, 5)
  
      date_range = Hotel::DateRange.new(start_date, end_date)
      puts "Date range = #{date_range}"

      reservation = Hotel::Reservation.new(date_range, 10)
      expect(reservation).must_respond_to :date_range
    end

  end
end