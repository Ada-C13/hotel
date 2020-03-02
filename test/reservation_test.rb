require_relative 'test_helper'

describe "Reservation class" do
  describe "#initialize" do
    it "creates an instance of Reservation class" do
      booking = Hotel::Reservation.new(1, 1, "test guest", "test start", "test end")
      expect(booking).must_be_instance_of Hotel::Reservation
    end
  end
end
