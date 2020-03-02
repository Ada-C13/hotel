require "date"
require_relative "test_helper"

describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      @reservation = Hotel::Reservation.new(date_range: nil, cost: nil, room: nil)
    end
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
    # tests for validating each parameter: date_range:, cost:, room:
  end
end
