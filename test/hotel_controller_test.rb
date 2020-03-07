require_relative "test_helper"
require "awesome_print"

describe "Hotel::HotelController" do

  before do
    @hotel = Hotel::HotelController.new
    def dt(day)
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
        reservation = @hotel.reserve_room(dt(1), dt(4))
        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      it "adds to the list of reservations" do 
        @hotel.reserve_room(dt(1), dt(4))
        expect(@hotel.reservations.size).must_equal 1
        @hotel.reserve_room(dt(1), dt(4))
        expect(@hotel.reservations.size).must_equal 2
      end

      it "selects the first available room" do
        # Reserve a room, than check if the reservation room equals to 1
        reservation1 = @hotel.reserve_room(dt(1), dt(4))
        expect(reservation1.room).must_equal 1
        expect(@hotel.reservations.last.room).must_equal 1

        # Reserve another room, than check if the reservation room equals 2
        reservation2 = @hotel.reserve_room(dt(1), dt(4))
        expect(reservation2.room).must_equal 2
        expect(@hotel.reservations.last.room).must_equal 2
      end

      it "returns error if no rooms are available" do
        # reserve 20 rooms (20.times). The 21st should return an error.
        (1..20).each do
          @hotel.reserve_room(dt(1), dt(4))
        end
        expect(@hotel.reservations.size).must_equal 20
        expect{ @hotel.reserve_room(dt(1), dt(4)) }.must_raise ArgumentError
        # it's ok to create more reservations in other date ranges
        @hotel.reserve_room(dt(15), dt(20))
        expect(@hotel.reservations.size).must_equal 21
      end

      it "does not accept the same date for start and end" do
        # create a reservation from 2020/01/05 to 2020/01/05. It should raise an exception
        expect{ @hotel.reserve_room(dt(5), dt(5)) }.must_raise ArgumentError
      end

      it "does not accept a start date after the end date" do
        # create a reservation from 2020/01/05 to 2020/01/01. It should raise an exception
        expect{ @hotel.reserve_room(dt(5), dt(1)) }.must_raise ArgumentError
      end
    end

    # access the list of reservations for a specific date to track reservations by date
    describe "reservations_by_date" do
      it "takes a Date and returns a list of Reservations" do
        @hotel.reserve_room(dt(1), dt(4))
        @hotel.reserve_room(dt(1), dt(4))
        reservations_ondate = @hotel.reservations_by_date(dt(1))

        expect(reservations_ondate).must_be_kind_of Array
        expect(reservations_ondate.size).must_equal 2

        reservations_ondate.each do |reservation|
          expect(reservation).must_be_kind_of Hotel::Reservation
        end
      end

      it "returns the reservation when you ask for the start date" do
        # create a reservation from 2020/01/01 to 2020/01/04, than get a list of reservations for 2020/01/01, should return 1
        @hotel.reserve_room(dt(1), dt(4))
        reservations_ondate = @hotel.reservations_by_date(dt(1))
        expect(reservations_ondate.size).must_equal 1
        # create another reservation from 2020/01/01 to 2020/01/05, than get a list of reservations for 2020/01/01, should return 2
        @hotel.reserve_room(dt(1), dt(5))
        reservations_ondate = @hotel.reservations_by_date(dt(1))
        expect(reservations_ondate.size).must_equal 2
        # create another reservation from 2020/01/05 to 2020/01/10, than get a list of reservations for 2020/01/05, should return 1
        @hotel.reserve_room(dt(5), dt(10))
        reservations_ondate = @hotel.reservations_by_date(dt(5))
        expect(reservations_ondate.size).must_equal 1
      end

      it "returns the reservation when you ask for a date in the middle" do
        # create a reservation from 2020/01/01 to 2020/01/10, than get a list of reservations for 2020/01/05. It should return 1
        @hotel.reserve_room(dt(1), dt(10))
        expect(@hotel.reservations_by_date(dt(5)).size).must_equal 1
        # create a reservation from 2020/01/02 to 2020/01/15, than get a list of reservations for 2020/01/05. It should return 2
        @hotel.reserve_room(dt(2), dt(15))
        expect(@hotel.reservations_by_date(dt(5)).size).must_equal 2
        # create a reservation from 2020/01/10 to 2020/01/15, than get a list of reservations for 2020/01/05. It should return 2
        @hotel.reserve_room(dt(10), dt(15))
        expect(@hotel.reservations_by_date(dt(5)).size).must_equal 2
      end

      it "does not return a reservation when you ask for the end date" do
        # create a reservation from 2020/01/01 to 2020/01/10, than get a list of reservations for 2020/01/10. It should return 0
        @hotel.reserve_room(dt(1), dt(10))
        expect(@hotel.reservations_by_date(dt(10)).size).must_equal 0
        # create a reservation from 2020/01/05 to 2020/01/10, than get a list of reservations for 2020/01/10. It should return 0
        @hotel.reserve_room(dt(5), dt(10))
        expect(@hotel.reservations_by_date(dt(10)).size).must_equal 0
      end

    end
  end

  # check whether reservations conflict with each other
  describe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        room_list = @hotel.available_rooms(dt(1), dt(4))
        expect(room_list).must_be_kind_of Array
      end

      it "removes a room after it is reserved" do
        @hotel.reserve_room(dt(1), dt(5))
        expect(@hotel.available_rooms(dt(1), dt(5)).size).must_equal 19
        @hotel.reserve_room(dt(1), dt(5))
        expect(@hotel.available_rooms(dt(1), dt(5)).size).must_equal 18
      end

      it "does not show the room available if there is an overlaping reservation" do
        # create a reservation from 2020/01/05 to 2020/01/15.
        @hotel.reserve_room(dt(5), dt(15))
        # Check overlap with same range
        expect(@hotel.available_rooms(dt(5), dt(15)).size).must_equal 19
        # Check overlap in the back
        expect(@hotel.available_rooms(dt(10), dt(20)).size).must_equal 19
        # Check overlap at the front
        expect(@hotel.available_rooms(dt(1), dt(10)).size).must_equal 19
        # Check overlap fully contained
        expect(@hotel.available_rooms(dt(7), dt(12)).size).must_equal 19
        # Check overlap fully containing
        expect(@hotel.available_rooms(dt(1), dt(20)).size).must_equal 19
        # Check no overlap fully before
        expect(@hotel.available_rooms(dt(1), dt(3)).size).must_equal 20
        # Check no overlap fully after
        expect(@hotel.available_rooms(dt(17), dt(20)).size).must_equal 20
        # Check no overlap on checkout date after
        expect(@hotel.available_rooms(dt(15), dt(20)).size).must_equal 20
        # Check no overlap on checkout date before
        expect(@hotel.available_rooms(dt(1), dt(5)).size).must_equal 20
      end

    end
  end # Wave 2 ***add coments to ends

  describe "wave 3" do
    # Create a Block for a Given Date Range, a Set of Rooms and a Rate
    describe "create_block" do 
      it "takes start/end/rooms/rate and returns Block" do
        block = @hotel.create_block(dt(1), dt(4), [3, 4, 5], 150)
        expect(block).must_be_kind_of Hotel::Block
      end

      it "raises and ArgumentError if the rooms are invalid " do
        expect{ @hotel.create_block(dt(1), dt(4), [1, 10, 18, 20, 21], 150) }.must_raise ArgumentError
      end

      it "raises and ArgumentError if more than 5 rooms" do
        expect{ @hotel.create_block(dt(1), dt(4), [1, 2, 3, 4, 5, 6], 150) }.must_raise ArgumentError
      end

      it "raises and ArgumentError if rooms is an empty array" do
        expect{ @hotel.create_block(dt(1), dt(4), [], 150) }.must_raise ArgumentError
      end
      
      it "raises and ArgumentError if room is unavailable " do
        # Create a reservation and try to block a room that is already reserved
        @hotel.reserve_room(dt(1), dt(4)) # this will reserve room number 1
        expect{ @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150) }.must_raise ArgumentError
        # Create a block and try to block a room that is already blocked (in another block)
        @hotel.create_block(dt(1), dt(4), [2, 3, 4], 150)
        expect{ @hotel.create_block(dt(1), dt(4), [4, 5, 6], 150) }.must_raise ArgumentError
        expect{ @hotel.create_block(dt(2), dt(3), [4, 5, 6], 150) }.must_raise ArgumentError
      end

      it "adds to the block list" do
        @hotel.create_block(dt(1), dt(4), [3, 4, 5], 150)
        expect(@hotel.blocks.size).must_equal 1
        @hotel.create_block(dt(1), dt(4), [6, 7, 8], 150)
        @hotel.create_block(dt(4), dt(8), [6, 7, 8], 150)
        expect(@hotel.blocks.size).must_equal 3
      end

      it "blocks reservations that conflict with a block" do # improve...
        @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150)
        reservation = @hotel.reserve_room(dt(1), dt(4)) # this should reserve room number 4 instead of 1
        expect(reservation.room).must_equal 4
      end

    end # Create Block

    describe "reserve_from_block" do

      # Create a Reservation from a Block
      # Reserve a specific room from a hotel block
      it "takes a block and a room. Returns a reservation" do
        block = @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150)
        reservation = @hotel.reserve_from_block(block, 2)
        expect(reservation).must_be_kind_of Hotel::Reservation
      end

      # trying to reserve from block without having a block
      it "raises an ArgumentError if the block is invalid" do
        expect{ @hotel.reserve_from_block(nil, 2) }.must_raise ArgumentError
        expect{ @hotel.reserve_from_block(1, 2) }.must_raise ArgumentError        
        expect{ @hotel.reserve_from_block(dt(1), 2) }.must_raise ArgumentError                
      end
      
      it "raises an ArgumentError if room is not in block" do
        block = @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150)
        expect{ @hotel.reserve_from_block(block, 4) }.must_raise ArgumentError
      end
      
      it "reserves room for the full duration of the block" do
        block = @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150)
        reservation = @hotel.reserve_from_block(block, 2)
        expect(reservation.range.start_date).must_equal block.range.start_date
        expect(reservation.range.end_date).must_equal block.range.end_date
      end

      it "raises an ArgumentError if the room is not available" do
        block = @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150)
        @hotel.reserve_from_block(block, 2)
        expect{ @hotel.reserve_from_block(block, 2) }.must_raise ArgumentError
      end

      it "adds to the list of reservations" do
        block = @hotel.create_block(dt(1), dt(4), [1, 2, 3], 150)
        @hotel.reserve_from_block(block, 2)
        expect(@hotel.reservations.size).must_equal 1
        reservation = @hotel.reserve_room(dt(1), dt(4))
        expect(@hotel.reservations.size).must_equal 2
        @hotel.reserve_from_block(block, 1)
        expect(@hotel.reservations.size).must_equal 3
        @hotel.reserve_from_block(block, 3)
        expect(@hotel.reservations.size).must_equal 4
      end

    end # Reserve from block
    
    # Check if Rooms for a Block are Valid
    describe "rooms_valid?" do
      it "returns true if the rooms are valid" do
        expect(@hotel.rooms_valid?([1, 2, 3])).must_equal true
        expect(@hotel.rooms_valid?([18, 19, 20])).must_equal true
        expect(@hotel.rooms_valid?([1])).must_equal true
        expect(@hotel.rooms_valid?([1, 2, 3, 4, 5, 20])).must_equal true
        expect(@hotel.rooms_valid?((1..20).to_a)).must_equal true
      end

      it "returns false if the rooms are invalid" do
        expect(@hotel.rooms_valid?([])).must_equal false
        expect(@hotel.rooms_valid?(nil)).must_equal false
        expect(@hotel.rooms_valid?(["1, 2, 3"])).must_equal false
        expect(@hotel.rooms_valid?([18, 19, 20, 21])).must_equal false
        expect(@hotel.rooms_valid?(1..20)).must_equal false
        end

    end

    # Check if the Rooms for a Block are Available in the Date Range
    # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable
    describe "block_rooms_available?" do
      it "returns true if the rooms are available in that date range" do
        
      end

      it "returns false if the rooms are not available in that date range" do

      end        
    end

    # Check if a Room is Not blocked in a Specific Date Range
    describe "is_room_unblocked?" do
      it "returns true if the room is not blocked in that date range" do
        
      end

      it "returns false if the room is blocked in that date range" do

      end        
    end
    
    # Checks whether a given block has any rooms available # test to fix this.
    describe "available_rooms_in(block)" do
      it "returns a list of rooms" do

      end

      it "returns all rooms if there are no reservations" do

      end

      it "returns fewer rooms after a reservation is made" do

      end

      it "returns an empty array if no rooms are left" do

      end
    end
  end # Wave 3
end