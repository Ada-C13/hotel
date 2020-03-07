require_relative "test_helper"

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
      end 
    end 

    # TO DO (think if there are more tests to add)
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


    describe "#find_all_reservations(date, room_type: 'all')" do 

      it "raises an ArgumentError when there is no reservation" do
        p "@hotel_manager.find_all_reservations(@date)"
        p @hotel_manager.find_all_reservations(@date)  
        expect(@hotel_manager.find_all_reservations(@date)).must_equal []
      end 

      it "raises an ArgumentError when receiving an invalid room_type" do 
        expect{@hotel_manager.find_all_reservations(@date, room_type: "every")}.must_raise ArgumentError
      end 

      it "returns 5 reservations on the specific date" do 
        6.times do 
          @hotel_manager.make_reservation(@date_range)
        end 

        # Make block reservation
        @hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5)

        reservations = @hotel_manager.find_all_reservations(@date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 11
        expect(reservations[0]).must_be_kind_of Hotel::Reservation
      end 

      it "returns 19 reservations on the specific date" do 

        @hotel_manager.make_reservation(@date_range)

        # TO DO
        test_date_range = Hotel::DateRange.new(Date.new(2020, 07, 11), Date.new(2020, 07, 13))

        10.times do 
          @hotel_manager.make_reservation(test_date_range)
        end 

        test_date_range_2 = Hotel::DateRange.new(Date.new(2020, 07, 6), Date.new(2020, 07, 12))

        9.times do 
          @hotel_manager.make_reservation(test_date_range_2)
        end 


        test_date = Date.new(2020, 07, 11)
        reservations = @hotel_manager.find_all_reservations(test_date)

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 19
        expect(reservations.last.room.id).must_equal 19
      end 
    end 


    describe "#find_all_reservations(date, room_type: 'individual')" do 
      it "returns reservation list for the individual room type" do 

       date = Date.new(2020, 07, 11)
       date_range = Hotel::DateRange.new(Date.new(2020, 07, 11), Date.new(2020, 07, 13))

       7.times do 
        @hotel_manager.make_reservation(date_range)
       end 

       @hotel_manager.make_block_reservation(date_range, number_of_rooms: 5)

       expect(@hotel_manager.find_all_reservations(date, room_type: "individual").length).must_equal 7
      end 

      it "raises an ArgumentError when receiving an invalid room_type" do 
        expect{@hotel_manager.find_all_reservations(@date, room_type: "test")}.must_raise ArgumentError
      end 
    end 

    describe "#add_reservation" do 
      it "adds a reservation in reservations" do 
        room = Hotel::Room.new(id: 8)
        reservation = Hotel::Reservation.new(@date_range, room)

        reservations = @hotel_manager.add_reservation(reservation)

        expect(reservations).must_be_instance_of Array
        expect(reservations.length).must_equal 1
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
    describe "#make_block_reservation(date_range, number_of_rooms: 2)" do 
      it "takes a date range & number of rooms and returns a Block Reservation" do 
        block = @hotel_manager.make_block_reservation(@date_range, number_of_rooms: 4)

        expect(block).must_be_instance_of Hotel::Block

        expect(block.rooms).must_be_kind_of Array
        expect(block.rooms[0]).must_be_kind_of Hotel::Room
        expect(block.reservations).must_be_kind_of Array
        expect(block.reservations[0]).must_be_kind_of Hotel::Reservation
        expect(block.total_block_cost).must_be_close_to 5 * (200 * 0.8) * 4, 0.01
      end 

      it "raises an ArgumentError if the number of rooms are not between 2 and 5" do 
  
        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 1)}.must_raise ArgumentError

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 6)}.must_raise ArgumentError

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 0)}.must_raise ArgumentError
      end 


      it "raise an ArgumentError if there are no available rooms for block (2 - 5 rooms)" do 

        # 20 rooms are booked for the same date range
        4.times do
          @hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5) 
        end 

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 5)}.must_raise ArgumentError


        # 18 rooms are booked for the same date range
        date_range_2 = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))

        6.times do 
          @hotel_manager.make_block_reservation(date_range_2, number_of_rooms: 3) 
        end 

        expect{@hotel_manager.make_block_reservation(@date_range, number_of_rooms: 4)}.must_raise ArgumentError
      end 
    end 

    describe "#find_all_reservations(date, room_type: 'block')" do 
      it "finds block reservations" do 

        date_range_1 = Hotel::DateRange.new(Date.new(2020, 11, 5), Date.new(2020, 11, 11))
        date_range_2 = Hotel::DateRange.new(Date.new(2020, 11, 7), Date.new(2020, 11, 9))
        date = Date.new(2020, 11, 9)

        # Made block reservations
        @hotel_manager.make_block_reservation(date_range_1, number_of_rooms: 5)

        # Not overlap
        @hotel_manager.make_block_reservation(date_range_2, number_of_rooms: 3)

        # Made a reservation for individual room type
        @hotel_manager.make_reservation(date_range_1)

        block_reservations = @hotel_manager.find_all_reservations(date, room_type: "block")

        # Because 11/9 is the end_date for date_range_2.
        expect(block_reservations).must_be_instance_of Array
        expect(block_reservations.length).must_equal 5
      end  

      it "raises an ArgumentError when receiving an invalid room_type" do 
        expect{@hotel_manager.find_all_reservations(@date, room_type: "blocking")}.must_raise ArgumentError
      end 
    end 
  end 
end
