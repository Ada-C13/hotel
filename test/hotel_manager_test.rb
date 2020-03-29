require_relative "test_helper"
require "awesome_print"

describe "HotelManager class" do
  before do
    @hotel_manager = Hotel::HotelManager.new()
    @date = Date.today + 50

    @date_range = Hotel::DateRange.new(Date.today + 50, Date.today + 55)
  end

  # wave 1
  describe "wave 1" do
    describe "#initialize" do
      it "returns a list of rooms" do
        rooms = @hotel_manager.rooms
        expect(rooms).must_be_kind_of Array

        rooms.each do |room|
          expect(room).must_be_instance_of Hotel::Room
        end

        expect(rooms[0].num).must_equal 1
      end
    end

    describe "#find_bookings_by_range(date_range)" do 
      it "returns a list of bookings for the given date range" do 
        date_range = Hotel::DateRange.new(Date.today, Date.today + 15)

        3.times do
          @hotel_manager.reserve_room(date_range)
        end

        bookings = @hotel_manager.find_bookings_by_range(date_range)

        expect(bookings).must_be_instance_of Array
        expect(bookings.length).must_equal 3
      end 
    end 


    describe "#bookings_per_room(date_range, room_num)" do
      it "returns a list of bookings for the specific room and the given date range" do
        date_range = Hotel::DateRange.new(Date.today + 52, Date.today + 54)

        @hotel_manager.reserve_room(@date_range)
        @hotel_manager.reserve_room(date_range)

        reservations_1 = @hotel_manager.bookings_per_room(@date_range, 1)
        reservations_2 = @hotel_manager.bookings_per_room(date_range, 2)

        expect(reservations_1).must_be_kind_of Array
        expect(reservations_2).must_be_kind_of Array

        expect(reservations_1[0]).must_be_kind_of Hotel::Reservation
        expect(reservations_2[0]).must_be_kind_of Hotel::Reservation

        expect(reservations_1[0].rooms[0].num).must_equal 1
        expect(reservations_2[0].rooms[0].num).must_equal 2
      end
    end


    describe "#find_bookings_by_date(date)" do
      it "returns 6 individual reservations and 1 block reservation within the specific date range" do
        6.times do
          @hotel_manager.reserve_room(@date_range)
        end

        # reserve block
        @hotel_manager.reserve_block(date_range: @date_range, room_qty: 5)

        reservations = @hotel_manager.find_bookings_by_date(@date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 7
        expect(reservations[0]).must_be_kind_of Hotel::Reservation
      end

      it "returns 19 reservations within specific date range" do
        @hotel_manager.reserve_room(@date_range)

        test_date_range = Hotel::DateRange.new(Date.today + 40, Date.today + 42)

        10.times do
          @hotel_manager.reserve_room(test_date_range)
        end

        test_date_range_2 = Hotel::DateRange.new(Date.today + 35, Date.today + 41)

        9.times do
          @hotel_manager.reserve_room(test_date_range_2)
        end

        test_date = Date.today + 40
        reservations = @hotel_manager.find_bookings_by_date(test_date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 19
        expect(reservations.last.rooms[0].num).must_equal 19
      end

      it "raises an ArgumentError when there is no reservation" do
        expect(@hotel_manager.find_bookings_by_date(@date)).must_equal []
      end
    end
  end


  describe "wave 2" do
    describe "#reserve_room" do
      it "takes a date range and returns a Reservation" do
        reservation = @hotel_manager.reserve_room(@date_range)

        expect(reservation).must_be_instance_of Hotel::Reservation
        expect(reservation.rooms[0]).must_be_instance_of Hotel::Room
        expect(reservation.rooms[0].num).must_equal 1
      end

      it "raise a NoRoomError error after making 20 reservations for the same date range" do
        20.times do
          @hotel_manager.reserve_room(@date_range)
        end

        expect {
          @hotel_manager.reserve_room(@date_range)
        }.must_raise Hotel::NoRoomError
      end

      it "raise a NoRoomError if there are no available rooms due to block reservation" do
        4.times do
          @hotel_manager.reserve_block(date_range: @date_range, room_qty: 5)
        end

        expect { @hotel_manager.reserve_room(@date_range) }.must_raise Hotel::NoRoomError
      end
    end


    describe "#add_reservation" do
      it "adds a reservation in reservations" do
        room = Hotel::Room.new(num: 8)
        reservation = Hotel::Reservation.new(date_range: @date_range, rooms: [room])

        reservations = @hotel_manager.add_reservation(reservation)

        expect(reservations).must_be_instance_of Array
        expect(reservations[0]).must_be_instance_of Hotel::Reservation
        expect(reservations[0].rooms[0].num).must_equal 8
      end
    end


    describe "#reserved_room_ids" do 
      it "returns reserved room_ids" do 
        5.times do 
          @hotel_manager.reserve_room(@date_range)
        end 

        reserved_room_ids = @hotel_manager.reserved_room_ids(@date_range)

        expect(reserved_room_ids.length).must_equal 5
      end 

      it "returns an empty array if there is no reservation" do 
        reserved_room_ids = @hotel_manager.reserved_room_ids(@date_range)

        expect(reserved_room_ids).must_equal []
      end 
    end 


    describe "#available_room_ids" do
      it "returns available rooms for the given date range" do
        available_room_ids = @hotel_manager.available_room_ids(@date_range)

        expect(available_room_ids).must_be_kind_of Array
        expect(available_room_ids.length).must_equal 20

        expect(available_room_ids[0]).must_be_kind_of Integer
      end

      it "returns the room #1 after making 20 reservations in a different date range" do
        date_range = Hotel::DateRange.new(Date.today + 50, Date.today + 55)
        new_date_range = Hotel::DateRange.new(Date.today + 41, Date.today + 46)

        20.times do
          @hotel_manager.reserve_room(date_range)
        end

        expect(@hotel_manager.available_room_ids(new_date_range)[0]).must_equal 1
      end

      it "returns the room #20 after making 19 reservations for the same date range" do
        19.times do
          @hotel_manager.reserve_room(@date_range)
        end

        expect(@hotel_manager.available_room_ids(@date_range)[0]).must_equal 20
      end

      it "raises an ArgumentError if there is no available room for the given date range" do 
        date_range = Hotel::DateRange.new(Date.today + 50, Date.today + 55)

        20.times do
          @hotel_manager.reserve_room(date_range)
        end

        expect{@hotel_manager.available_room_ids(date_range)}.must_raise Hotel::NoRoomError
      end 
    end
  end

  describe "wave 3" do
    describe "#reserve_block(date_range: , room_qty: 2)" do
      it "takes a date range & number of rooms and returns a Block Reservation" do
        block_reservation = @hotel_manager.reserve_block(date_range: @date_range, room_qty: 5)

        expect(block_reservation).must_be_instance_of Hotel::Block

        expect(block_reservation.rooms).must_be_kind_of Array

        expect(block_reservation.rooms[0]).must_be_kind_of Hotel::Room
      end

      it "raises an ArgumentError if the number of rooms is not between 2 and 5" do
        expect { @hotel_manager.reserve_block(date_range: @date_range, room_qty: 6) }.must_raise ArgumentError

        expect { @hotel_manager.reserve_block(date_range: @date_range, room_qty: 0) }.must_raise ArgumentError
      end

      it "raise a NoRoomError if there are no available rooms for block" do
        4.times do
          @hotel_manager.reserve_block(date_range: @date_range, room_qty: 5)
        end

        expect { @hotel_manager.reserve_block(date_range: @date_range, room_qty: 5) }.must_raise Hotel::NoRoomError
      end

      it "raise a NoRoomError if there are no available rooms for block due to individual reservations" do
        20.times do
          @hotel_manager.reserve_room(@date_range)
        end

        expect { @hotel_manager.reserve_block(date_range: @date_range, room_qty: 5) }.must_raise Hotel::NoRoomError
      end

    end

    describe "find_room_by_id(number)" do 
      it "returns a Room instance by the given id" do
        room = @hotel_manager.find_room_by_id(5)

        expect(room).must_be_kind_of Hotel::Room
        expect(room.num).must_equal 5
      end 
    end 
  end
end
