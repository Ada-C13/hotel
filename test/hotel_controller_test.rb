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

    describe "total_cost" do
      it "takes a reservation and returns the cost for that reservation" do
        today = Date.today
        room_one = @hotel_controller.rooms.first
       
        new_reservation = Hotel::Reservation.new(today + 6, today + 9, room_one)

        total_cost_for_reservation = @hotel_controller.total_cost(new_reservation)
        expect(total_cost_for_reservation).must_be_kind_of Numeric

      end
    end
    

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        today = Date.today

        new_reservation = @hotel_controller.reserve_room(today + 6, today + 9)
        expect(new_reservation).must_be_kind_of Hotel::Reservation
      end

      it "is an NoRoomAvalable if avalable_room is nil" do
        start_date = Date.new(2020, 4, 10)
        end_date = Date.new(2020, 4, 12)
        room_number = 0
        while room_number < 20 do
          @hotel_controller.reserve_room(start_date, end_date)
          room_number += 1
        end

        #avalable_room = @hotel_controller.reserve_room(start_date, end_date)
        expect{(@hotel_controller.reserve_room(start_date, end_date))}.must_raise Hotel::NoRoomAvailable
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
          start_date = Date.new(2020, 4, 10)
          end_date = Date.new(2020, 4, 12)

          room_one = @hotel_controller.rooms[0]
          room_two = @hotel_controller.rooms[1]
    
          
          @hotel_controller.reservations = [
            Hotel::Reservation.new(start_date, end_date, room_one),
            Hotel::Reservation.new(start_date, end_date, room_two),
          ]

          room_list = @hotel_controller.available_rooms(start_date + 1 , end_date + 1)

          expect(room_list).must_be_kind_of Array
          expect(room_list.length).must_equal 18
          expect(room_list[-1].room_nr).must_equal 20
        end
      end
    end
  end
end