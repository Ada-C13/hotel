require_relative "test_helper"

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end
  describe "wave 1" do
    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3
        room_number = 10
        rate = 200

        reservation = @hotel_controller.reserve_room(start_date, end_date, room_number, rate)

        expect(reservation).must_be_kind_of Hotel::Reservation
        expect(@hotel_controller.reservations.size).must_equal(1)
      end
    end

    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations_by_date(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Reservation
        end
      end
    end
  end

  describe "wave 2" do
    describe "available_rooms" do
      before do
        @room_number = 1
        #@hotel_controller.rooms
      end

      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)


        expect(room_list).must_be_kind_of Array
        expect(room_list).must_equal((1..20).to_a)
      end

      it "doesn't return reserved room" do
        start_date = @date
        end_date = start_date + 3
      

        @hotel_controller.reserve_room(start_date, end_date, 10, 200)
        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
        expect(room_list.size).must_equal(19)
      end

      it "returns room if booking date isn't overlap" do
        start_date = @date
        end_date = start_date + 3

        @hotel_controller.reserve_room(@date + 4, @date + 5, 8, 200)
        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
        expect(room_list.size).must_equal(20)
      end
    end
  end
end