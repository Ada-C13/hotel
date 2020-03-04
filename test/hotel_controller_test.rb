require_relative "test_helper"

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end
  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        rooms = @hotel_controller.rooms
        expect(rooms).must_be_kind_of Array
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      it "start_date and end_date should be instances of class Date" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation.end_date).must_be_kind_of Date
        expect(reservation.start_date).must_be_kind_of Date
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
      it "takes a Date and returns a list of Reservations" do
        reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10")
        reservation2 = @hotel_controller.reserve_room("2020-08-04", "2020-08-08")
        reservation3 = @hotel_controller.reserve_room("2020-08-09", "2020-08-12")

        reservation_list = @hotel_controller.reservations("2020-08-04")

        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list[0].start_date).must_be_kind_of Date
        expect(reservation_list[0].start_date).must_equal Date.parse("2020-08-04")
        expect(reservation_list[0].end_date).must_equal Date.parse("2020-08-10")
        expect(reservation_list[1].start_date).must_equal Date.parse("2020-08-04")
        expect(reservation_list[1].end_date).must_equal Date.parse("2020-08-08")
        
        reservation_list1 = @hotel_controller.reservations("2020-08-11")
        expect(reservation_list1[0].start_date).must_equal Date.parse("2020-08-09")
        expect(reservation_list1[0].end_date).must_equal Date.parse("2020-08-12")
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