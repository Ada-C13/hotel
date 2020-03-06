require_relative "test_helper"

describe Hotel::HotelController do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-03-04")
  end

  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        rooms = @hotel_controller.list_rooms
        expect(rooms).must_be_instance_of Array
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_instance_of Hotel::Reservation
      end

      describe "make a reservation of a room for given date range" do
        before do
          19.times do |index|
            room_num = index + 1
            room_to_reserve = @hotel_controller.rooms.find { |room| room.room_number == room_num}
            @hotel_controller.reserve_room(Date.new(2020,01,01), Date.new(2020,01,05),room_to_reserve)
          end
        end
        
        it "room will not be part of any other reservation overlapping that date range" do
          expect(@hotel_controller.available_rooms(Date.new(2020,01,01),Date.new(2020,01,05)).length).must_equal 1
        end

        it "raises an exception if attempt to reserve a room during a date range when all rooms are reserved" do
          @hotel_controller.reserve_room(Date.new(2020,01,01), Date.new(2020,01,05),@hotel_controller.rooms.find { |room| room.room_number == 20})
          expect{@hotel_controller.reserve_room(Date.new(2020,01,01), Date.new(2020,01,05))}.must_raise RuntimeError
        end

      end

    end

    describe "reservations" do
      before do
        @hotel_controller.reserve_room(Date.new(2020,01,01), Date.new(2020,01,05),@hotel_controller.rooms.find { |room| room.room_number == 1})
        @hotel_controller.reserve_room(Date.new(2020,02,01), Date.new(2020,02,05),@hotel_controller.rooms.find { |room| room.room_number == 2})
        @hotel_controller.reserve_room(Date.new(2020,03,01), Date.new(2020,03,05), @hotel_controller.rooms.find { |room| room.room_number == 3})
        @hotel_controller.reserve_room(Date.new(2020,03,01), Date.new(2020,03,10),@hotel_controller.rooms.find { |room| room.room_number == 4})
        @hotel_controller.reserve_room(Date.new(2020,03,04), Date.new(2020,03,06),@hotel_controller.rooms.find { |room| room.room_number == 5})
        @reservation_list = @hotel_controller.reservations(@date)
      end

      it "takes a Date and returns a list of Reservations" do
        expect(@reservation_list).must_be_instance_of Array
        @reservation_list.each do |res|
          res.must_be_instance_of Hotel::Reservation
        end
      end

      it "returns an accurate list of reservations" do
        expect(@reservation_list.length).must_equal 3
      end

    end
  end

  describe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3
        room_list = @hotel_controller.available_rooms(start_date, end_date)
        expect(room_list).must_be_instance_of Array
      end

      it "raises ArgumentError if start date is not at least 1 day before end date" do
        start_date = Date.new(2020,03,05)
        end_date = start_date - 3
        expect{@hotel_controller.available_rooms(start_date, end_date)}.must_raise ArgumentError
      end

      it "correctly returns avail rooms after one room is reserved for a specific date range" do
        new_res = @hotel_controller.reserve_room(Date.new(2020,03,06), Date.new(2020,03,10))
        avail_rooms = @hotel_controller.available_rooms(Date.new(2020,03,05),Date.new(2020,03,07))

        expect(avail_rooms).must_be_instance_of Array
        expect(avail_rooms[0]).must_be_instance_of Hotel::Room
        expect(avail_rooms.length).must_equal 19
        expect(avail_rooms.include?(new_res.room)).must_equal false
        
      end

    end
  end
end