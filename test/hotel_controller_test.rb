require_relative "test_helper"

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
  end

  describe "initialize" do
    it "is an instance of HotelController" do
      expect(@hotel_controller).must_be_kind_of Hotel::HotelController
    end

    it "rooms is a type of array" do
      expect(@hotel_controller.rooms).must_be_kind_of Array
    end

    it "rooms array has 20 items" do
      expect(@hotel_controller.rooms.length).must_equal 20
    end
  end  
 

  describe "wave 1" do

    describe "reserve_room" do
      before do
        @range = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 3)
        @hotel_controller.reserve_room(@range)
        @hotel_controller.available_rooms(@range)
      end

    
      it "creates a Reservation" do
        @reserved = @hotel_controller.reserve_room(@range)
        expect(@reserved).must_be_kind_of Hotel::Reservation
        # reservation = @hotel_controller.reserve_room(@range)
        # expect(@hotel_controller.reservations[0]).must_be_instance_of Hotel::Reservation
        # reservation_list.each do |res|
        #   res.must_be_kind_of Hotel::Reservation
      end
      
    end

    xdescribe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array

        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end
    end
  end

  describe "wave 2" do
    describe "available_rooms" do

      before do
        @range = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 3)
        @hotel_controller.available_rooms(@range)
      end

      it "takes date range and returns a list" do

        room_list = @hotel_controller.available_rooms(@range)
        expect(room_list).must_be_kind_of Array
      end
    end
  end
end