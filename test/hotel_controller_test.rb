require_relative "test_helper"

describe Hotel::HotelController do 
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
    @rooms = Array.new(20){|i| Hotel::Room.new(i+1)}
  end
  describe "wave 1" do
    describe "initializer" do

      it "Creates an instance of hotel controler" do
        @hotel_controller.must_be_kind_of Hotel::HotelController
      end

      it "create the rooms" do
        rooms = @hotel_controller.rooms
        expect(rooms).must_be_kind_of Array
      end

      it "create 20 rooms" do
        rooms = @hotel_controller.rooms
        expect(rooms.length).must_equal 20
      end

      it "create an empty array for reservatios" do
        reservations = @hotel_controller.reservations
        expect(reservations).must_equal []
      end
    end

    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservation(@date)
        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        today = Date.today

        reservation = @hotel_controller.reserve_room(today + 1, today + 2)
        room_one = Hotel::Room.new(1)

        expect(reservation).must_be_kind_of Hotel::Reservation

      end
    end

    describe "reservations_for" do
      it "takes a date_range and room returns a list of Reservations" do
        today = Date.today
        room_one = Hotel::Room.new(1)
        room_two = Hotel::Room.new(2)

        reservation = Hotel::Reservation.new(today + 6, today + 9, room_one)

        @hotel_controller.reservations = [
          Hotel::Reservation.new(today + 1, today + 2, room_one),
          Hotel::Reservation.new(today + 6, today + 9, room_two),
          reservation,
          Hotel::Reservation.new(today + 10, today + 13, room_one)
        ]

        reservation_list = @hotel_controller.reservations_for_room(Hotel::DateRange.new(today + 5, today + 9), room_one)
        expect(reservation_list).must_be_kind_of Array
        expect(reservation_list).must_equal [reservation] 

      end
    end
        
    describe "wave 2" do
      describe "available_rooms" do
        it "takes two dates and returns a list" do
          # today = Date.today
          start_date = Date.new(2020, 4, 10)
          end_date = Date.new(2020, 4, 12)

          # room_one = Hotel::Room.new(1)
          room_one = @hotel_controller.rooms.first
          
          @hotel_controller.reservations = [
            Hotel::Reservation.new(start_date, end_date, room_one),
            # Hotel::Reservation.new(start_date, end_date, room_two)
          ]
          # puts "reservations = #{@hotel_controller.reservations}"

          room_list = @hotel_controller.available_rooms(start_date, end_date)
          puts "ROOM LIST = #{room_list}"

          # puts"/n/n"

          # puts "rooms - reservatoins = #{@rooms - @hotel_controller.reservations}"

          expect(room_list).must_be_kind_of Array
          expect(room_list.length).must_equal 19
          expect(room_list[-1].room_nr).must_equal 20
          # expect(room_list[0].room_nr).must_equal 3

        end
      end
    end
  end
end