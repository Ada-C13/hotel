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
        room = 10
        room_list = @hotel_controller.available_rooms(start_date, end_date, room)

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end

# make a reservation of a room for a given date range, and that room will not be part of any other reservation overlapping that date range
# want an exception raised if I try to reserve a room during a date range when all rooms are reserved, so that I cannot make two reservations for the same room that overlap by date

# Details
# A reservation is allowed start on the same day that another reservation for the same room ends
