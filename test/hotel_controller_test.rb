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
    describe "reservations" do
      before do
        @hotel_controller.reserve_room(Date.new(2020,01,01), Date.new(2020,01,05))
        @hotel_controller.reserve_room(Date.new(2020,02,01), Date.new(2020,02,05))
        @hotel_controller.reserve_room(Date.new(2020,03,01), Date.new(2020,03,05))
        @hotel_controller.reserve_room(Date.new(2020,03,01), Date.new(2020,03,10))
        @hotel_controller.reserve_room(Date.new(2020,03,04), Date.new(2020,03,06))
        @reservation_list = @hotel_controller.reservations(@date)
      end

      it "takes a Date and returns a list of Reservations" do
        expect(@reservation_list).must_be_kind_of Array
        @reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
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

  describe "wave 2" do
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