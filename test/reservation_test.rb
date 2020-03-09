require_relative 'test_helper'

describe "Reservation class" do
  before do
    @new_hotel = Hotel::HotelController.new(10)
    @new_hotel.reserve_room(Date.new(2010,02,10),Date.new(2010,02,13), "Sharon")
    @new_reservation = @new_hotel.reservation_list[1]
  end

  describe "Initializer" do
    it "is an instance of Reservation" do
      expect(@new_reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "cost" do
    it "will calculate the total cost of the reservation" do
      expect(@new_reservation.cost).must_equal  600
    end
  end

  describe "check_valid_room(request_room)" do
    it "will return true if the request room matches with the room the reservation itself" do
      expect(@new_reservation.check_valid_room("Room 1")).must_equal true
      expect(@new_reservation.check_valid_room("Room 10")).must_equal false
    end
  end
 
  describe "check_status" do 
    it "will return false is the status of the reservation is not equal to :open_hotel_block" do
      expect(@new_reservation.check_status).must_equal false
    end
  end
end
 