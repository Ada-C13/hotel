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

        expect(reservations_list_of_given_room_date_range.length).must_equal 2    #
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
    describe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations_list(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
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
      it "takes two dates and returns a list" do
        room = @hotel_controller.rooms.first
        reservation = Hotel::Reservation.new(1, @date_range,room)
        @hotel_controller.add_reservation(reservation)
        
        test_start_date = Date.new(2020, 8, 01)
        test_end_date = test_start_date + 29
        room_list = @hotel_controller.available_rooms(test_start_date, test_end_date)
    
        expect(room_list).must_be_kind_of Array
        expect(room_list.length).must_equal 19
      end

      describe "reserve_room" do
        it "takes two Date objects and returns a Reservation" do
          reservation = @hotel_controller.reserve_room(@start_date, @end_date)
  
          expect(reservation).must_be_kind_of Hotel::Reservation
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
        @discount_rate = 0.1
      end
      describe "#create a HotelBock with given date_range, rooms, and discount_rate" do
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
          expect{(@hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate))}.must_raise ArgumentError
        end
        it "raise an ArgumentEorror if at least one of the rooms is unavailable for the given date range - by checking the existing hotel_blocks" do 
        
          new_hotel_block1 = @hotel_controller.create_hotel_block(@date_range, @rooms_array, @discount_rate)
          
          # Cannot create a hotel block that any existing block includes that specific room for that specific date
          expect{(@hotel_controller.create_hotel_block(@date_range, @rooms_array1, @discount_rate))}.must_raise ArgumentError
        end
      end
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
      describe "reserve_from_hotel_block" do

        it "can reserve a room form a hotel block for a full duration of the block" do
        end

        it "See a reservation made from a hotel block from the list of reservations for that date" do
          
        end

        it "remove the specific room from the rooms_array once it is reserverse" do
 
        
        end

        it "create a new reservation based on the hotel_block and added to reservations list" do
          
        end
        
        it "cannot reserve a specific room the HotelBock where the date is not exact macth the full duration of the block " do
          
        end

        it "When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block" do
          
        end
        

      describe "can check whether a given block has any rooms available" do
      
      end

  
          
        
      end
    end
    
  end








end
