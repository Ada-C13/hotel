require_relative "test_helper"

describe "Reservation" do
  describe "Initialize" do
    it "Create an instance of Reservation" do
      reservation = Hotel::Reservation.new(id: 1, room: 3, start_date: "March 3, 2020", end_date: "March 3, 2020")
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Room id tracker" do
      reservation = Hotel::Reservation.new(id: 1, room: 3, start_date: "March 3, 2020", end_date: "March 3, 2020")
      expect(reservation).must_respond_to :id
      expect(reservation.id).must_equal 1
    end
  end  
end