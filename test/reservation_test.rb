require_relative 'test_helper'

describe "Reservation class" do
  before do
    @new_hotel = Hotel::HotelController.new
    @new_hotel.reserve_room(Date.new(2010,02,10),Date.new(2010,02,13),3)
    @new_reservation = @new_hotel.reservation_list[1]
  end

  describe "Initializer" do
    it "is an instance of Reservation" do
      expect(@new_hotel.reservation_list[1]).must_be_kind_of Hotel::Reservation
    end
  end

  describe "cost" do
    it "will calculate the total cost of the reservation" do
      expect(@new_reservation.cost).must_equal  600
    end
  end
   
end
