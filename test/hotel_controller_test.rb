require_relative "test_helper"

describe Hotel::HotelController do 
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end
  describe "wave 1" do
    describe "initializer" do

      it "Creates an instance of hotel controler" do
        @hotel_controller.must_be_kind_of Hotel::HotelController
      end
      #make one more test for initializer


      it "create the rooms" do
        rooms = @hotel_controller.rooms
        expect(@hotel_controller.rooms).must_be_kind_of Array
      end

      it "create an empty array for reservatios" do
        reservations = @hotel_controller.reservations
        expect(@hotel_controller.reservations).must_equal []
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "reservations_for" do
      it "takes a date_range and room returns a list of Reservations" do
        today = Date.today
        room_one = Hotel::Room.new(1)
        room_two = Hotel::Room.new(2)

        reservation = Hotel::Reservation.new(3, today + 6, today + 9, room_one)

        @hotel_controller.reservations = [
          Hotel::Reservation.new(1, today + 1, today + 2, room_one),
          Hotel::Reservation.new(2, today + 6, today + 9, room_two),
          reservation,
          Hotel::Reservation.new(4, today + 10, today + 13, room_one)
        ]


        reservation_list = @hotel_controller.reservations_for(Hotel::DateRange.new(today + 5, today + 9), room_one)
        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list).must_equal [reservation]   
      end
    end
  end

  # describe "wave 2" do
  #   describe "available_rooms" do
  #     it "takes two dates and returns a list" do
  #       start_date = @date
  #       end_date = start_date + 3

  #       room_list = @hotel_controller.available_rooms(start_date, end_date)

  #       expect(room_list).must_be_kind_of Array
  #     end
  #   end
  # end
end