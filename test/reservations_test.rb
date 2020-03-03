require_relative 'test_helper'

describe "reservations" do
  describe "initialize reservations" do
    before do
      @new_reservation = Hotel::Reservation.new( id: 1, start_date: "3/4/2020", end_date: "3/9/2020", room: Hotel::Room.new(room_number: 1, cost: 200))
    end

    it "creates an instance of a reservation" do
      expect(@new_reservation).must_be_instance_of Hotel::Reservation
    end

    it "converts start and end dates to instances of Date class" do
      expect(@new_reservation.start_date).must_be_instance_of Date
      expect(@new_reservation.end_date).must_be_instance_of Date
    end

    it "raises ArgumentError if end date is before start date" do
      expect{Hotel::Reservation.new( id: 1, start_date: "3/4/2020", end_date: "3/3/2020")}.must_raise ArgumentError
    end

    it "has an attribute of room that is an instance of Room class" do
      expect(@new_reservation.room).must_be_instance_of Hotel::Room
    end
  end
  
end