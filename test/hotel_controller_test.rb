require_relative "test_helper"

describe Hotel::HotelController do 
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
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
    end

    describe "reservations_list_room_and_date" do
      it "when there is no reservation, retrun a empty reservation list for a specified room and a given date range" do
        room = Hotel::Room.new(1, 200)
        start_date = Date.today
        end_date = start_date + 3
        date_range = Hotel::DateRange.new(start_date,end_date)
        reservations_list = @hotel_controller.reservations_list_room_and_date(room,date_range)

        expect(reservations_list).must_equal []
      end

      it "return a reservation list for a specified room and a given date range" do
        # reservation with date_range1
        room = Hotel::Room.new(1, 200)
        start_date1 = Date.new(2017, 01, 03)
        end_date1 = start_date1 + 3
        date_range1 = Hotel::DateRange.new(start_date1,end_date1) 
        reservation1 = Hotel::Reservation.new(1, date_range1,room)  
        @hotel_controller.add_reservation(reservation1)

        # reservation with data_range2
      
        start_date2 = Date.new(2017, 01, 10)
        end_date2 = start_date2 + 4
        date_range2 = Hotel::DateRange.new(start_date2,end_date2)
        reservation2 = Hotel::Reservation.new(1, date_range2,room)
        @hotel_controller.add_reservation(reservation2)
       
        # test_date_range
        test_start_date = Date.new(2017, 01, 01)
        test_end_date = test_start_date + 30
        test_date_range = Hotel::DateRange.new(test_start_date,test_end_date)
  
        # we expect to return a list of reservations of the same rooms with different date_ranges
        reservations_list_of_given_room_date_range = @hotel_controller.reservations_list_room_and_date(room, test_date_range)
        # print reservations_list_of_given_room_date_range

        expect(reservations_list_of_given_room_date_range).must_be_kind_of Array
        reservations_list_of_given_room_date_range.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end

        expect(reservations_list_of_given_room_date_range.length).must_equal 2
      end
    end

    describe "add_reservation" do 
      it "add a new reservation to the reservations list" do
        room = @hotel_controller.rooms[0]
        start_date1 = Date.new(2017, 01, 03)
        end_date1 = start_date1 + 3
        date_range1 = Hotel::DateRange.new(start_date1,end_date1) 
        reservation1 = Hotel::Reservation.new(1, date_range1,room) 

        expect(@hotel_controller.reservations).must_equal []
        @hotel_controller.add_reservation(reservation1)
        expect(@hotel_controller.reservations.length).must_equal 1
      end
    end

    # Access the list of reservations for a specific date (NOT a DATE RANGE), so that I can track reservations by date
    describe "reservations_list" do
      it "return a list of reservations for a specific date" do
        room = Hotel::Room.new(1, 200)
        start_date1 = Date.new(2017, 01, 03)
        end_date1 = start_date1 + 3
        date_range1 = Hotel::DateRange.new(start_date1,end_date1) 
        reservation1 = Hotel::Reservation.new(1, date_range1,room)  
        @hotel_controller.add_reservation(reservation1)

        # reservation with data_range2
      
        start_date2 = Date.new(2017, 01, 10)
        end_date2 = start_date2 + 4
        date_range2 = Hotel::DateRange.new(start_date2,end_date2)
        reservation2 = Hotel::Reservation.new(1, date_range2,room)
        @hotel_controller.add_reservation(reservation2)

        test_date1 = Date.new(2017, 01, 01)
        test_date2 = Date.new(2017, 01, 03)
        reservation_list1 = @hotel_controller.reservations_list(test_date1)
        reservation_list2 = @hotel_controller.reservations_list(test_date2)

        expect(reservation_list1).must_be_kind_of Array
        reservation_list1.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
        expect(reservation_list1.length).must_equal 0
        expect(reservation_list2).must_be_kind_of Array
        reservation_list2.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
        expect(reservation_list2.length).must_equal 1
      end 
    end

    describe "total_cost" do
      it "return a total cost of a given reservation" do
        start_date = Date.today
        end_date = start_date + 4
        reservation = @hotel_controller.reserve_room(start_date, end_date)
        expect(reservation.cost).must_equal 800
      end  
    end

    # Get reserved_rooms_list for a given date range
    describe "reservations_list_by_date_range" do
      it "return a reservations_list_by_date_range for a given date range" do
        room = Hotel::Room.new(1, 200)
        start_date1 = Date.new(2017, 01, 03)
        end_date1 = start_date1 + 3
        date_range1 = Hotel::DateRange.new(start_date1,end_date1) 
        reservation1 = Hotel::Reservation.new(1, date_range1,room)  
        @hotel_controller.add_reservation(reservation1)

        # reservation with data_range2
      
        start_date2 = Date.new(2017, 01, 28)
        end_date2 = start_date2 + 11
        date_range2 = Hotel::DateRange.new(start_date2,end_date2)
        reservation2 = Hotel::Reservation.new(1, date_range2,room)
        @hotel_controller.add_reservation(reservation2)

        test_start_date = Date.new(2017, 01, 01 )
        test_end_date = test_start_date + 30
        reservations_list_by_date_range = @hotel_controller.reservations_list_by_date_range(test_start_date, test_end_date)

        expect(reservations_list_by_date_range).must_be_kind_of Array
        reservations_list_by_date_range.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end

        expect(reservations_list_by_date_range.length).must_equal 2
      end
    end
  end

  describe "wave 2" do
    before do
      @start_date = Date.new(2020, 8, 10)
      @end_date = @start_date + 4
      @date_range = Hotel::DateRange.new(@start_date,@end_date)
    end 

    describe "available_rooms" do
      before do 
        @room1 = @hotel_controller.rooms[0]
        @room2 = @hotel_controller.rooms[1]
        @room3 = @hotel_controller.rooms[2]
        @room4 = @hotel_controller.rooms[3]
        @room5 = @hotel_controller.rooms[4]
        @rooms_array = [@room2, @room3]
        @discount_rate = 0.1
      end
      it "takes two dates and returns a list of available_rooms" do
        reservation = Hotel::Reservation.new(1, @date_range,@room1)
        @hotel_controller.add_reservation(reservation)
        
        test_start_date = Date.new(2020, 8, 01)
        test_end_date = test_start_date + 29
        room_list = @hotel_controller.available_rooms(test_start_date, test_end_date)
    
        expect(room_list).must_be_kind_of Array
        expect(room_list.length).must_equal 19
        expect(@hotel_controller.hotel_blocks).must_equal []
        expect(@hotel_controller.hotel_blocks.length).must_equal 0
      end

      it "available_rooms should not already been reserved in reservations or in the hotel block for those specific date range" do
        start_date = Date.new(2020, 8, 20)
        end_date = start_date + 5
        block_date_range = Hotel::DateRange.new(start_date, end_date)
        reservation = Hotel::Reservation.new(1, @date_range,@room1)
        @hotel_controller.add_reservation(reservation)
        new_hotel_block = @hotel_controller.create_hotel_block(block_date_range, @rooms_array, @discount_rate)

        test_start_date = Date.new(2020, 8, 01)
        test_end_date = test_start_date + 29
        room_list = @hotel_controller.available_rooms(test_start_date, test_end_date)

        expect(room_list).must_be_kind_of Array
        expect(room_list.length).must_equal 17

      end

      describe "reserve_room" do
        it "takes two Date objects and returns a Reservation" do
          reservation = @hotel_controller.reserve_room(@start_date, @end_date)
  
          expect(reservation).must_be_kind_of Hotel::Reservation
          expect(@hotel_controller.reservations.length).must_equal 1
        end
  
        it "The ability to reserve room when there are reservations with the same start_date and end_date" do
          start_date = Date.today
          end_date = start_date + 4
          reservation1 = @hotel_controller.reserve_room(start_date, end_date)
          reservation2 = @hotel_controller.reserve_room(start_date, end_date)
  
          expect(@hotel_controller.reservations.length).must_equal 2
          expect(reservation2.room.id).must_equal 2
        end 

        it "raise ArgumentError when there is no room available" do 
          start_date = Date.today
          end_date = start_date + 4
  
          num_room = 0
          while num_room < 20 do
            @hotel_controller.reserve_room(start_date, end_date)
            num_room +=1 
          end

          expect{(@hotel_controller.reserve_room(start_date, end_date))}.must_raise Hotel::NoRoomAvailableError
        end
      end
    end

    describe "Wave 3" do
      before do
        @start_date = Date.new(2020, 8, 10)
        @end_date = @start_date + 4
        @date_range = Hotel::DateRange.new(@start_date,@end_date)
        @room1 = @hotel_controller.rooms[0]
        @room2 = @hotel_controller.rooms[1]
        @room3 = @hotel_controller.rooms[2]
        @room4 = @hotel_controller.rooms[3]
        @room5 = @hotel_controller.rooms[4]
        @rooms_array = [@room1, @room2]
        @rooms_array1 = [@room1, @room2, @room3, @room4]
        @rooms_array2 = [@room3, @room4]
        @rooms_array_empty = []
        @discount_rate = 0.1
      end

      describe "create_hotel_block" do
        it "create a HotelBlock when all the rooms of rooms_array are avaible " do
          new_hotel_block = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          expect(new_hotel_block).must_be_kind_of Hotel::HotelBlock
          expect(@hotel_controller.hotel_blocks).must_be_kind_of Array
          expect(@hotel_controller.hotel_blocks.length).must_equal 1 
      end

        it "raise an ArgumentEorror if at least one of the rooms is unavailable for the given date range - by checking the reservations list " do 
          # Make a reservation so it will take the first room, so the first room is no longer available
          reservation1 = @hotel_controller.reserve_room(@start_date, @end_date)

          # Now, when we try to create a block that has room_id = 1, it will raise ArgumentError 
          # @room_array contains @room1 which was already reserved for the same date range
          expect{(@hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate))}.must_raise ArgumentError
        end
        it "raise an ArgumentEorror if at least one of the rooms is unavailable for the given date range - by checking the existing hotel_blocks" do 
        
          new_hotel_block1 = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          # @rooms_array = [@room1, @room2]
          # @rooms_array1 = [@room1, @room2, @room3, @room4]
          # Cannot create a hotel block that any existing block includes that specific room for that specific date
          expect{(@hotel_controller.create_hotel_block(@date_range, @rooms_array1, @discount_rate))}.must_raise ArgumentError
        end
      end

      describe "add_hotel_block" do
        it "add a hotel_block to the hotel_blocks list" do
          # before creating the hotel_block, hotel_blocks list is empty
          expect(@hotel_controller.hotel_blocks).must_equal []

          new_hotel_block = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          expect(@hotel_controller.hotel_blocks.length).must_equal 1
        end
      end

      # Get the hotel_block_list for a given date (not exact match date range)
      describe "hotel_block_list" do
        it "return an empty array of hotel_block_list if there is no hotel_block created" do
          test_start_date = Date.new(2020, 8, 01)
          test_end_date = test_start_date + 29
          hotel_block_list = @hotel_controller.hotel_block_list(test_start_date, test_end_date)

          expect(hotel_block_list).must_equal []
        end
        it "return a hotel_block_list for a given date range" do
          start_date2 = Date.new(2020, 8, 16)
          end_date2 = start_date2 + 5
          date_range2 = Hotel::DateRange.new(start_date2, end_date2)
          new_hotel_block1 = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range2, @rooms_array1, @discount_rate)
          
          test_start_date = Date.new(2020, 8, 01)
          test_end_date = test_start_date + 29
          hotel_block_list = @hotel_controller.hotel_block_list(test_start_date, test_end_date)
          
          expect(hotel_block_list).must_be_kind_of Array
          expect(hotel_block_list.length).must_equal 2
        end
      end

      # Get the hotel_block_list for a given date (not exact match date range)
      describe "rooms_list_for_hotel_block" do
        it "return a room_list_of_hotel_block for a given data range" do
          start_date2 = Date.new(2020, 8, 16)
          end_date2 = start_date2 + 5
          date_range2 = Hotel::DateRange.new(start_date2, end_date2)
          new_hotel_block1 = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range2, @rooms_array1, @discount_rate)
          
          # serching the room_list_for_hotel_block for the whole month
          # we have two hotel_blocks that over lap for the whole month in Aguest 
          test_start_date = Date.new(2020, 8, 01)
          test_end_date = test_start_date + 29
          rooms_list_for_hotel_block = @hotel_controller.rooms_list_for_hotel_block(test_start_date, test_end_date)
          
          expect(@hotel_controller.hotel_blocks).must_be_kind_of Array
          expect(@hotel_controller.hotel_blocks.length).must_equal 2
          expect(rooms_list_for_hotel_block).must_be_kind_of Array
          expect(rooms_list_for_hotel_block.length).must_equal 6
        end
      end

      describe "available_rooms_of_block" do
        it "check whether a given hotel block has any rooms available" do
          new_hotel_block = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          available_rooms_of_block = @hotel_controller.available_rooms_of_block(new_hotel_block)
          expect(@hotel_controller.rooms).must_be_kind_of Array
          expect(new_hotel_block.rooms.length).must_equal 2
          expect(available_rooms_of_block).must_equal @rooms_array
        end

        it "check whether a given block has any rooms available - if @rooms_array is empty print There is no room available" do
          
          expect{(@hotel_controller.create_hotel_block(@date_range, @rooms_array_empty, @discount_rate))}.must_raise ArgumentError 
        end
      end

      # Get the list of the hotel_block for a specific full date range (exact match the full date range)
      describe "hotel_blocks_for_specific_date_range" do
        it "return a list of hotel_blocks_for_specific_date_range for the exact match the full date range" do
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range, @rooms_array2, @discount_rate)
          
          test_start_date = Date.new(2020, 8, 16)
          test_end_date = test_start_date + 5
          hotel_blocks_for_specific_date_range = @hotel_controller.hotel_blocks_for_specific_date_range(test_start_date, test_end_date)
          
          expect(hotel_blocks_for_specific_date_range).must_be_kind_of Array
          expect(hotel_blocks_for_specific_date_range.length).must_equal 2
        end

        it "return a empty array of list of hotel_blocks_for_specific_date_range for given date_range that doesn't exactly match the full date range of the hotel blocks" do
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range, @rooms_array2, @discount_rate)
          
          test_start_date = Date.new(2020, 8, 16)
          test_end_date = test_start_date + 4
          hotel_blocks_for_specific_date_range = @hotel_controller.hotel_blocks_for_specific_date_range(test_start_date, test_end_date)
          
          expect(hotel_blocks_for_specific_date_range).must_be_kind_of Array
          expect(hotel_blocks_for_specific_date_range.length).must_equal 0
        end
      end

      # Get available_rooms_of_hotel_blocks for a specific full date range (exact match the full date range)
      describe "available_rooms_of_hotel_blocks" do
        it "return a available_room_of_hotel_blocks for the exact match of given date range" do
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range, @rooms_array2, @discount_rate)
          
          test_start_date = Date.new(2020, 8, 16)
          test_end_date = test_start_date + 5
          hotel_blocks_for_specific_date_range = @hotel_controller.available_rooms_of_hotel_blocks(test_start_date, test_end_date)
          
          expect(hotel_blocks_for_specific_date_range).must_be_kind_of Array
          expect(hotel_blocks_for_specific_date_range.length).must_equal 4
        end

        it "return a empty array of list of hotel_blocks_for_specific_date_range for given date_range that doesn't exactly match the full date range of the hotel blocks" do
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range, @rooms_array2, @discount_rate)
          
          test_start_date = Date.new(2020, 8, 16)
          test_end_date = test_start_date + 4
      
          expect{(@hotel_controller.available_rooms_of_hotel_blocks(test_start_date, test_end_date))}.must_raise ArgumentError
        end
      end

      # Get specific hotel_block with a given room, start_date, and end_date
      describe "specific_hotel_block" do
        it "return specific_hotel_block when we know at least one room of the rooms_array and date_range" do
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)

        # @rooms_array = [@room1, @room2]
        # @rooms_array2 = [@room3, @room4]
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range, @rooms_array2, @discount_rate)

          specific_hotel_block = @hotel_controller.specific_hotel_block(@room1, start_date, end_date)
          expect(specific_hotel_block).must_be_kind_of Hotel::HotelBlock
          expect(specific_hotel_block.rooms).must_equal @rooms_array
        end

        it "raise ArgumentError when there is no hotel_block found for that given room or date_range" do
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)

        # @rooms_array = [@room1, @room2]
        # @rooms_array2 = [@room3, @room4]
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range, @rooms_array2, @discount_rate)

          test_start_date = Date.new(2020, 8, 16)
          test_end_date = test_start_date + 6
          
          expect{(@hotel_controller.specific_hotel_block(@room1, test_start_date, test_end_date))}.must_raise ArgumentError
        end
      end

      describe "remove_room_from_hotel_block" do 
        it "the specific room is removed from the list of rooms of the specific hotel_block" do
        # @rooms_array = [@room1, @room2]
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
        
        # @rooms_array1 = [@room1, @room2, @room3, @room4]
          start_date2 = Date.new(2020, 8, 10)
          end_date2 = start_date2 + 2
          date_range2 = Hotel::DateRange.new(start_date2, end_date2)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range2, @rooms_array1, @discount_rate)

          # Before removing @room1 
          expect(new_hotel_block1).must_be_kind_of Hotel::HotelBlock
          expect(new_hotel_block1.rooms).must_equal @rooms_array
          expect(new_hotel_block1.rooms.length).must_equal 2
          expect(p new_hotel_block1.rooms).must_equal [@room1, @room2]

          # After removing @room1
          @hotel_controller.remove_room_from_hotel_block(@room1, start_date, end_date)
          expect(new_hotel_block1).must_be_kind_of Hotel::HotelBlock
          expect(new_hotel_block1.rooms).must_equal @rooms_array
          expect(new_hotel_block1.rooms.length).must_equal 1
          expect(p new_hotel_block1.rooms).must_equal [@room2]

          # the removing doesn't impact new_hotel_block2 
          expect(new_hotel_block2).must_be_kind_of Hotel::HotelBlock
          expect(new_hotel_block2.rooms).must_equal @rooms_array1
          expect(new_hotel_block2.rooms.length).must_equal 4
          expect(p new_hotel_block2.rooms).must_equal [@room1, @room2, @room3, @room4]
        end
      end

      describe "delete_hotel_block" do
        it "delete a hotel_block from hotel_blocks list for given hotel_block" do
          # @rooms_array = [@room1, @room2]
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
        
        # @rooms_array1 = [@room1, @room2, @room3, @room4]
          start_date2 = Date.new(2020, 8, 10)
          end_date2 = start_date2 + 2
          date_range2 = Hotel::DateRange.new(start_date2, end_date2)
          new_hotel_block2 = @hotel_controller.create_hotel_block(date_range2, @rooms_array1, @discount_rate)

        # Before deleting a hotel_block
          expect(@hotel_controller.hotel_blocks).must_be_kind_of Array
          expect(@hotel_controller.hotel_blocks.length).must_equal 2

        # After deleting a hotel_block
        @hotel_controller.delete_hotel_block(new_hotel_block2)
        expect(@hotel_controller.hotel_blocks).must_be_kind_of Array
        expect(@hotel_controller.hotel_blocks.length).must_equal 1
        end
      end
      
      describe "reserve_from_hotel_block" do
        it "Can reserve a room form a hotel block for a full duration of the block" do
        # @rooms_array = [@room1, @room2]
          start_date = Date.new(2020, 8, 16)
          end_date = start_date + 5
          date_range = Hotel::DateRange.new(start_date, end_date)
          new_hotel_block1 = @hotel_controller.create_hotel_block(date_range, @rooms_array, @discount_rate)
        
          expect(@hotel_controller.reservations).must_equal []
          expect(@hotel_controller.reservations.length).must_equal 0
          expect(@hotel_controller.hotel_blocks[0]).must_be_kind_of Hotel::HotelBlock
          expect(@hotel_controller.hotel_blocks.length).must_equal 1
        # reserve @room1 from new_hotel_block1
          @hotel_controller.reserve_room_from_hotel_block(@room1,start_date, end_date)
  
        # After reserve @room1 from new_hotel_block1
          expect(@hotel_controller.reservations.length).must_equal 1
          expect(@hotel_controller.reservations[0]).must_be_kind_of Hotel::Reservation
          expect(@hotel_controller.hotel_blocks[0]).must_be_kind_of Hotel::HotelBlock
          expect(@hotel_controller.hotel_blocks.length).must_equal 1
          expect(new_hotel_block1.rooms.length).must_equal 1 # @room 1 was removed from @rooms_array = [@room1, @room2]

        # reserve @room2 from new_hotel_block1
          @hotel_controller.reserve_room_from_hotel_block(@room2,start_date, end_date)
          expect(@hotel_controller.reservations.length).must_equal 2
          # since @room1 and @room2 were removed the new_hotel_block1 will be deleted beacuse it's rooms_array is an empty array
          expect(@hotel_controller.hotel_blocks.length).must_equal 0 
        end        
      end
    end 
  end
end
