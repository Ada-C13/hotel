require_relative "test_helper"

describe Hotel::Reservation do
  describe "cost" do
    it "returns a number" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      room_rate = 200
      reservation = Hotel::Reservation.new(start_date, end_date, room_rate)
      expect(reservation.cost).must_be_kind_of Numeric
    end
    it "calculates cost accurately" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      # date_range = Hotel::DateRange.new(
      #   start_date:[2020,3,2],end_date:[2020,3,5])
      room_rate = 200
      reservation = Hotel::Reservation.new(start_date, end_date, room_rate)
      expect(reservation.cost).must_equal 400
  end
end
end