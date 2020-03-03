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

      it "return 20 rooms" do
        expect(@hotel_controller.rooms.size).must_equal 20
      end

      it "return 20 rooms numbered 1 through 20" do
        (1..20).each do |room|
          expect(@hotel_controller.rooms.include?(room)).must_equal true
        end
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

  # access the list of reservations for a specific date, so that I can track reservations by date
    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        start_date = @date
        end_date   = start_date + 3
        reservation1 = @hotel_controller.reserve_room(start_date, end_date)
        reservation2 = @hotel_controller.reserve_room(start_date, end_date)

        reservations_ondate = @hotel_controller.reservations(@date)

        expect(reservations_ondate).must_be_kind_of Array
        expect(reservations_ondate.size).must_equal 2

        reservations_ondate.each do |reservation|
          expect(reservation).must_be_kind_of Hotel::Reservation
        end
      end
    end
  end

  # check whether reservations conflict with each other (this will come in wave 2!)
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
# access the list of reservations for a specified room and a given date range


# User Stories - As a user of the hotel system...I can/want to...so that I can/can't

# HotelController - access the list of all of the rooms in the hotel "Who has the list of all the rooms in the hotel?"
# HotelController - access the list of reservations for a specified room and a given date range "Who has access to that?"
# HotelController - access the list of reservations for a specific date, so that I can track reservations by date
# Reservation     - get the total cost for a given reservation
# DateRange       - want exception raised when an invalid date range is provided, so I can't make a reservation for an invalid date range

# Details

# HotelController - the hotel has 20 rooms, numbered 1 through 20 (array from 1 to 20)
# Reservation     - every room is identical and costs $200/night (constant cost $200)
# DateRange       - last day is the checkout day, guest shouldn't be charged for that day/night (end_day doesn't count)
# HotelController - given only start and end dates, determine which room to use for the reservation

# For this wave, you don't need to check whether reservations conflict with each other (this will come in wave 2!)

