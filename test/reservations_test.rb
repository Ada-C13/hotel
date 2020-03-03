require_relative 'test_helper'

describe "reservations" do
  describe "initialize reservations" do
    it "creates an instance of a reservation" do
      expect(Hotel::Reservation.new( id: 1, start_date: "3/4/2020", end_date: "3/9/2020")).must_be_instance_of Hotel::Reservation
    end
  end
  
end