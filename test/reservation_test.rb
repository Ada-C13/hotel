require_relative "test_helper"

describe Hotel::Reservation do
  describe "cost" do
    it "returns a number" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      room_number = 7
      rate = 200
      reservation = Hotel::Reservation.new(start_date, end_date, room_number, rate)
      expect(reservation.cost).must_be_kind_of Numeric
    end
  end
end
