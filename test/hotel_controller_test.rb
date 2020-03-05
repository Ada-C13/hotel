require_relative "test_helper"

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new(
      reservations: [],
      rooms: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
    )
    @date = Date.new(2020, 8, 4)
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
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end
      
    end

    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Reservation
        end
      end
    end
  end

  xdescribe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end