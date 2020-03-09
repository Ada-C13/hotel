require_relative "test_helper"
require 'awesome_print'

describe "HotelManager class" do
  before do
    @hotel_manager = Hotel::HotelManager.new()
    @date = Date.new(2020, 8, 10)

    @date_range = Hotel::DateRange.new(Date.new(2020, 8, 10), Date.new(2020, 8, 15))
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

        expect(rooms[0].id).must_equal 1
      end
    end

    describe "#reservations_per_room" do 
      it "returns a list of reservations for the specific room" do 

        room = @hotel_manager.rooms[0]

        reservations = @hotel_manager.reservations_per_room(@date_range, room)

        expect(reservations).must_be_kind_of Array

        reservations.each do |reservation| 
          expect(reservation).must_be_kind_of Hotel::Reservation
        end 

        date_range = Hotel::DateRange.new(Date.new(2020, 8, 10), Date.new(2020, 8, 15))
        
        reservation = Hotel::Reservation.new(date_range, room: Hotel::Room.new(id: 2))
        Hotel::HotelManager.new().add_reservation(reservation, type: :individual)
      end 
    end 


    describe "#make_reservation" do 
      it "takes a date range and returns a Reservation" do 
        reservation = @hotel_manager.make_reservation(@date_range)

        expect(reservation).must_be_instance_of Hotel::Reservation 
        expect(reservation.room).must_be_instance_of Hotel::Room
        expect(reservation.room.id).must_equal 1
      end 

      it "raise an Arugment error after making 20 reservations for the same date range" do 

        20.times do 
          @hotel_manager.make_reservation(@date_range)
        end 
 
        expect{
          @hotel_manager.make_reservation(@date_range)
        }.must_raise ArgumentError
      end 
    end 


    describe "#find_reservations(date)" do 

      it "raises an ArgumentError when there is no reservation" do
        expect(@hotel_manager.find_reservations(@date)).must_equal []
      end 

      it "returns 6 individual reservations within the specific date range" do 

        6.times do 
          @hotel_manager.make_reservation(@date_range)
        end 

        # ---- Make block reservations for a test reason ----
        @hotel_manager.set_block(@date_range, number_of_rooms: 5)  
        @hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5)
        # ---------------------------------

        reservations = @hotel_manager.find_reservations(@date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 6
        expect(reservations[0]).must_be_kind_of Hotel::Reservation
      end 

      it "returns 19 reservations within specific date range" do 

        @hotel_manager.make_reservation(@date_range)

        test_date_range = Hotel::DateRange.new(Date.new(2020, 07, 11), Date.new(2020, 07, 13))

        10.times do 
          @hotel_manager.make_reservation(test_date_range)
        end 

        test_date_range_2 = Hotel::DateRange.new(Date.new(2020, 07, 6), Date.new(2020, 07, 12))

        9.times do 
          @hotel_manager.make_reservation(test_date_range_2)
        end 


        test_date = Date.new(2020, 07, 11)
        reservations = @hotel_manager.find_reservations(test_date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 19
        expect(reservations.last.room.id).must_equal 19
      end 
    end 


    describe "#add_reservation" do 
      it "adds a reservation in reservations" do 
        room = Hotel::Room.new(id: 8)
        reservation = Hotel::Reservation.new(@date_range, room: room)

        reservations = @hotel_manager.add_reservation(reservation, type: :individual)

        expect(reservations).must_be_instance_of Array
        expect(reservations[0]).must_be_instance_of Hotel::Reservation
        expect(reservations[0].room.id).must_equal 8
      end 
    end 
  end

  describe "wave 2" do 
    describe "#available_room_ids" do 
      it "returns available rooms for the given date range" do 

        available_room_ids = @hotel_manager.available_room_ids(@date_range)

        expect(available_room_ids).must_be_kind_of Array
        expect(available_room_ids.length).must_equal 20 

        expect(available_room_ids[0]).must_be_kind_of Integer
      end 

      it "returns the room #1 after making 20 reservations in a different date range" do 
        date_range = Hotel::DateRange.new(Date.new(2020, 8, 10), Date.new(2020, 8, 15))
        new_date_range = Hotel::DateRange.new(Date.new(2020, 8, 1), Date.new(2020, 8, 6))

        20.times do 
          @hotel_manager.make_reservation(date_range)
        end 

        expect(@hotel_manager.available_room_ids(new_date_range)[0]).must_equal 1
      end 

      it "returns the room #20 after making 19 reservations for the same date range" do 
        19.times do 
          @hotel_manager.make_reservation(@date_range)
        end 
 
        expect(@hotel_manager.available_room_ids(@date_range)[0]).must_equal 20
      end 
    end 
  end 


  describe "wave 3" do
    describe "#block_reservations_per_room" do 
      it "takes date_range & room and returns block Reservations per room" do 
        date_range = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        @hotel_manager.set_block(date_range, number_of_rooms: 3)
        @hotel_manager.set_block(date_range, number_of_rooms: 5)

        @hotel_manager.make_block_reservation(date_range, number_of_rooms: 3)
        @hotel_manager.make_block_reservation(date_range, number_of_rooms: 5)


        room = @hotel_manager.find_room_by_id(20)

        reservations = @hotel_manager.block_reservations_per_room(date_range, room)

        expect(reservations.length).must_equal 2 

        expect(reservations[0].block.rooms.length).must_equal 3

        # TO DO (Need to Refactor) - checking room numbers for block
        expect(reservations[0].block.rooms[0].id).must_equal 20
        expect(reservations[0].block.rooms[1].id).must_equal 19

        expect(reservations[1].block.rooms.length).must_equal 5
      end 
    end 

   
    describe "@set_block(date_range, number_of_rooms: 1)" do 
      it "takes a date range & number of rooms and returns a Block" do 
        block = @hotel_manager.set_block(@date_range, number_of_rooms: 4)

        expect(block).must_be_kind_of Hotel::Block

        expect(@hotel_manager.blocks.length).must_equal 1
      end 
    end 

    describe "#available_blocks(date_range, number_of_rooms: number_of_rooms)" do 
      it "returns an available block within the specific date range" do
        @hotel_manager.set_block(@date_range, number_of_rooms: 4)
        
        available_blocks = @hotel_manager.available_blocks(@date_range, number_of_rooms: 4)

        expect(available_blocks[0].rooms.length).must_equal 4
      end 
    end 


    describe "#make_block_reservation(date_range, number_of_rooms: 2)" do 
      it "takes a date range & number of rooms and returns a Block Reservation" do 
        @hotel_manager.set_block(@date_range, number_of_rooms: 5)

        block_reservation = @hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5)

        expect(block_reservation).must_be_instance_of Hotel::Reservation

        expect(block_reservation.block).must_be_kind_of Hotel::Block

        expect(block_reservation.block.rooms).must_be_kind_of Array

        expect(block_reservation.block.rooms[0]).must_be_kind_of Hotel::Room
      end 

      it "raises an ArgumentError if the number of rooms is not between 1 and 5" do 

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 6)}.must_raise ArgumentError

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 0)}.must_raise ArgumentError
      end 


      # Need to refactor to raise an ArgumentError if all rooms are taken by block
      it "raise an ArgumentError if there are no available rooms for block" do 

        4.times do 
          @hotel_manager.set_block(@date_range, number_of_rooms: 5)
        end 

        # 20 rooms are booked for the same date range
        4.times do
          @hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5) 
        end 

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5)}.must_raise ArgumentError
      end 


      # Need to refactor
      # how to reserve a specific room from a hotel block
      it "raises an ArgumentError if number of rooms does not match with a set of block" do
        date_range = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        @hotel_manager.set_block(date_range, number_of_rooms: 5) 

        expect{@hotel_manager.make_block_reservation(date_range, number_of_rooms: 1)}.must_raise ArgumentError
      end 
    end 

    describe "#find_block_reservations(date_range)" do 
      it "finds block reservations" do 

        date_range_1 = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        @hotel_manager.set_block(date_range_1, number_of_rooms: 5)

        # Made block reservations
        @hotel_manager.make_block_reservation(date_range_1, number_of_rooms: 5)

        found_reservations = @hotel_manager.find_block_reservations(date_range_1)

        expect(found_reservations).must_be_instance_of Array
        expect(found_reservations.length).must_equal 1
        expect(found_reservations[0].block.rooms.length).must_equal 5
      end  
    end 

    describe "#set_block" do 
      it "takes date_range and number_of_rooms and returns a block" do 
        date_range = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        block = @hotel_manager.set_block(date_range, number_of_rooms: 3)

        expect(block).must_be_instance_of Hotel::Block
      end 

      it "raises an ArgumentError if the number of rooms is not between 1 and 5" do 
        date_range = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        expect{@hotel_manager.set_block(date_range, number_of_rooms: 6)}.must_raise ArgumentError

        expect{@hotel_manager.set_block(date_range, number_of_rooms: 7)}.must_raise ArgumentError
      end 

      it "raises an ArgumentError if the requested number of rooms is less than available rooms" do 

        date_range = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        16.times do 
          @hotel_manager.make_reservation(date_range)
        end 

        expect{@hotel_manager.set_block(date_range, number_of_rooms: 5)}.must_raise ArgumentError
      end 
    end
  end 
end
