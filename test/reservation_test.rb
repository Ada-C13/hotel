require "date"
require_relative "test_helper"

describe "Reservation class" do
  describe "Initializer" do
    let(:check_in_date) { Date.new(2001, 2, 3) }
    let(:check_out_date) { Date.new(2001, 2, 6) }
    it "is an instance of Reservation" do
      res = Reservation.new(Room.new(1),check_in_date, check_out_date)
      expect(res).must_be_kind_of Reservation
    end

    it "takes in the date" do
      res = Reservation.new(Room.new(1),check_in_date, check_out_date)
      expect(res.total_cost_for_stay).must_equal 600
    end
  end
end
