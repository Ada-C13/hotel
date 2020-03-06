require_relative 'test_helper'

describe "reservations" do
  before do
    @new_reservation = Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date: Date.today + 2, end_date: Date.today + 6), room: Hotel::Room.new(room_number: 1, cost: 200))
  end

  describe "initialize reservations" do

    it "creates a Reservation object" do
      expect(@new_reservation).must_be_instance_of Hotel::Reservation
    end

    it "has an attribute of date_range that is an instance of Date_Range class" do
      expect(@new_reservation.date_range).must_be_instance_of Hotel::DateRange
    end

    it "has an attribute of room that is an instance of Room class" do
      expect(@new_reservation.room).must_be_instance_of Hotel::Room
    end
  end
  
end