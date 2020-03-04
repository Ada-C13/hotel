require_relative "test_helper"
require "awesome_print"

describe "Hotel::HotelController" do

  before do
    @hotel = Hotel::HotelController.new
    def test_date(day)
      return Date.new(2020, 01, day)
    end
  end

  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        expect(@hotel.rooms).must_be_kind_of Array
      end

      it "return 20 rooms" do
        expect(@hotel.rooms.size).must_equal 20
      end

      it "return 20 rooms numbered 1 through 20" do
        (1..20).each do |room|
          expect(@hotel.rooms.include?(room)).must_equal true
        end
      end
    end

    describe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        reservation = @hotel.reserve_room(test_date(1), test_date(4))
        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      it "adds to the list of reservations" do 
        reservation1 = @hotel.reserve_room(test_date(1), test_date(4))
        expect(@hotel.reservations.size).must_equal 1
        reservation2 = @hotel.reserve_room(test_date(1), test_date(4))
        expect(@hotel.reservations.size).must_equal 2
      end

      it "selects the first available room" do
        # reserve a room, than check if the reservation room equals to 1
        reservation1 = @hotel.reserve_room(test_date(1), test_date(4))
        expect(reservation1.room).must_equal 1
        expect(@hotel.reservations.last.room).must_equal 1
        # reserve another room, than check if the reservation room equals 2
        reservation2 = @hotel.reserve_room(test_date(1), test_date(4))
        expect(reservation2.room).must_equal 2
        expect(@hotel.reservations.last.room).must_equal 2
      end

      it "returns error if no rooms are available" do #
        # reserve 20 rooms (20.times). The 21st should return an error.
        (1..20).each do |reservation|
          reservation = @hotel.reserve_room(test_date(1), test_date(4))
        end
        # expect(@hotel.reservations.size).must_equal 20
        expect{ @hotel.reserve_room(test_date(1), test_date(4)) }.must_raise ArgumentError
      end

      it "does not accept the same date for start and end" do #
        # create a reservation from 2020/01/05 to 2020/01/05. It should raise an exception
        expect{ @hotel.reserve_room(test_date(1), test_date(1)) }.must_raise ArgumentError
      end

      it "does not accept a start date after the end date" do #
        # create a reservation from 2020/01/05 to 2020/01/01. It should raise an exception
        expect{ @hotel.reserve_room(test_date(5), test_date(1)) }.must_raise ArgumentError
      end
    end

    # access the list of reservations for a specific date, so that I can track reservations by date
    describe "reservations_by_date" do
      it "takes a Date and returns a list of Reservations" do
        reservation1 = @hotel.reserve_room(test_date(1), test_date(4))
        reservation2 = @hotel.reserve_room(test_date(1), test_date(4))

        reservations_ondate = @hotel.reservations_by_date(test_date(1))

        expect(reservations_ondate).must_be_kind_of Array
        expect(reservations_ondate.size).must_equal 2

        reservations_ondate.each do |reservation|
          expect(reservation).must_be_kind_of Hotel::Reservation
        end
      end

      it "returns the reservation when you ask for the start date" do
        # create a reservation from 2020/01/01 to 2020/01/04, than get a list of reservations for 2020/01/01, should return 1
        reservation1 = @hotel.reserve_room(test_date(1), test_date(4))
        reservations_ondate = @hotel.reservations_by_date(test_date(1))
        expect(reservations_ondate.size).must_equal 1 #
        # create another reservation from 2020/01/01 to 2020/01/05, than get a list of reservations for 2020/01/01, should return 2
        reservation2 = @hotel.reserve_room(test_date(1), test_date(5))
        reservations_ondate = @hotel.reservations_by_date(test_date(1))
        expect(reservations_ondate.size).must_equal 2 #
        # create another reservation from 2020/01/05 to 2020/01/10, than get a list of reservations for 2020/01/05, should return 2
        reservation3 = @hotel.reserve_room(test_date(5), test_date(10))
        ap @hotel.reservations
        reservations_ondate = @hotel.reservations_by_date(test_date(5))
        ap reservations_ondate
        expect(reservations_ondate.size).must_equal 2 #
      end

      it "returns the reservation when you ask for a date in the middle" do
        # create a reservation from 2020/01/01 to 2020/01/10, than get a list of reservations for 2020/01/05. It should return 1
        # create a reservation from 2020/01/02 to 2020/01/15, than get a list of reservations for 2020/01/05. It should return 2
        # create a reservation from 2020/01/10 to 2020/01/15, than get a list of reservations for 2020/01/05. It should return 2
      end

      it "does not return a reservation when you ask for the end date" do
        # create a reservation from 2020/01/01 to 2020/01/10, than get a list of reservations for 2020/01/10. It should return 0
        # create a reservation from 2020/01/05 to 2020/01/10, than get a list of reservations for 2020/01/10. It should return 0
      end

    end
  end

  # check whether reservations conflict with each other
  describe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        room_list = @hotel.available_rooms(test_date(1), test_date(4))
        expect(room_list).must_be_kind_of Array
      end

      it "removes a room after it is reserved" do
        reservation1 = @hotel.reserve_room(test_date(1), test_date(5))
        expect(@hotel.available_rooms(test_date(1), test_date(5)).size).must_equal 19
        reservation1 = @hotel.reserve_room(test_date(1), test_date(5))
        expect(@hotel.available_rooms(test_date(1), test_date(5)).size).must_equal 18
      end

      it "does not show the room available if there is an overlaping reservation" do
        # create a reservation from 2020/01/05 to 2020/01/15.
        # Check if the list of available rooms from 2020/01/10 to 2020/01/20 has 19 rooms
        # Check if the list of available rooms from 2020/01/01 to 2020/01/10 has 19 rooms
        # Check if the list of available rooms from 2020/01/07 to 2020/01/12 has 19 rooms
        # Check if the list of available rooms from 2020/01/01 to 2020/01/20 has 19 rooms
        # Check if the list of available rooms from 2020/01/01 to 2020/01/03 has 20 rooms
        # Check if the list of available rooms from 2020/01/17 to 2020/01/20 has 20 rooms
        # Check if the list of available rooms from 2020/01/15 to 2020/01/20 has 20 rooms
      end

    end
  end

end