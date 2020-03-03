require_relative "test_helper"

describe "Hotel::HotelController" do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end

  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        expect(@hotel_controller.rooms).must_be_kind_of Array
      end
    end
     
    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date   = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation # included module name
        end
      end
    end
  end

  describe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        start_date = @date
        end_date   = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date) # DateRange?

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end


# HotelController - access the list of all of the rooms in the hotel
# HotelController - access the list of reservations for a specified room and a given date range
# HotelController - access the list of reservations for a specific date, so that I can track reservations by date
# HotelController - The hotel has 20 rooms, and they are numbered 1 through 20
# HotelController - When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation
# HotelController -  Check whether reservations conflict with each other (this will come in wave 2!)
