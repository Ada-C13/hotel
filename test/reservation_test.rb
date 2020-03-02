require_relative 'test_helper'

describe "Reservation class" do
  describe "initializer" do
    before do
      @date = Hotel::DateRange.new(Date.new, Date.new + 2)
      @occupancy = {room_id: "1", guest: "Picchu"}
      @reservation = Hotel::Reservation.new("single", @date, @occupancy)
    end

    it "is an instance of Reservation object" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
  
end