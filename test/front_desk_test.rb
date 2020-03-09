require_relative 'test_helper'

describe "front desk" do
  before do
    @front_desk = Hotel::FrontDesk.new
    @dates = Hotel::DateRange.new(start_date: Date.today + 2, end_date: Date.today + 6)
    @block_count = 3
    @discount_cost = 0.2
  end

  describe "initialize FrontDesk" do
    
    it "creates a FrontDesk object" do
      expect(@front_desk).must_be_instance_of Hotel::FrontDesk
    end
    
    it "stores all 20 hotel rooms" do
      expect(@front_desk.rooms.count).must_equal 20
    end

    it "returns an array of the 20 rooms" do
      expect(@front_desk.rooms).must_be_instance_of Array
    end

    it "stores instances of the Room class inside the array" do
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
    end
  end

  describe "add_reservation" do
    before do
      @front_desk.add_reservation(@dates)
    end

    it "raises exception when there are no available rooms for a given date range" do
      19.times do
        @front_desk.add_reservation(@dates)
      end

      expect{@front_desk.add_reservation(@dates)}.must_raise NoAvailableRoomError 
      
    end

    it "adds an instance of the room class to the reservation" do
      expect(@front_desk.reservations[0].room).must_be_instance_of Hotel::Room
    end

    it "does not add a reservation to a room if the room is not in a block" do 
      @front_desk.request_block(3, @dates, 180) 
      @front_desk.add_reservation(@dates)
      expect(@front_desk.reservations[1].room.room_number).must_equal 5
    end

    it "adds a reservation object to collection of reservations" do
      expect(@front_desk.reservations[0]).must_be_instance_of Hotel::Reservation
    end

    it " adds the reservation to the room object" do
      expect(@front_desk.reservations[0].room.reservations[0]).must_be_instance_of Hotel::Reservation
    end

  end

  describe "available_rooms" do

    it "returns an array of all available rooms given a date range" do
      expect(@front_desk.available_rooms(@dates)).must_be_instance_of Array
    end

    it "has room objects contained in the array" do
      expect(@front_desk.available_rooms(@dates).sample).must_be_instance_of Hotel::Room
    end

    it "returns array of all rooms for a given date range if no reservations exist for any room" do
      expect(@front_desk.available_rooms(@dates).count).must_equal 20
      expect(@front_desk.available_rooms(@dates)[0].room_number).must_equal 1
    end

    it "returns array of all rooms for a given date range that don't overlap the date range" do
      @front_desk.add_reservation(@dates)
      expect(@front_desk.available_rooms(@dates).count).must_equal 19
      expect(@front_desk.available_rooms(@dates)[0].room_number).must_equal 2

      @front_desk.add_reservation(@dates)

      expect(@front_desk.available_rooms(@dates).count).must_equal 18
      expect(@front_desk.available_rooms(@dates)[0].room_number).must_equal 3

      new_dates = Hotel::DateRange.new(start_date: Date.today + 6, end_date: Date.today + 10)
      @front_desk.add_reservation(new_dates)

      expect(@front_desk.available_rooms(@dates).count).must_equal 18
      expect(@front_desk.available_rooms(@dates)[0].room_number).must_equal 3

      test_dates = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 2)
      expect(@front_desk.available_rooms(test_dates).count).must_equal 20
      expect(@front_desk.available_rooms(test_dates)[0].room_number).must_equal 1
    end    

  end

  describe "find_reservation_with" do
    before do
      @room = @front_desk.rooms[0]
    end

    it "returns an array of reservations that match the date" do
      expect(@front_desk.find_reservation_with(room: @room, date_range: @dates)).must_be_instance_of Array
    end

    it "returns an empty array if there are no reservations" do
      expect(@front_desk.find_reservation_with(room: @room, date_range: @dates).sample).must_equal nil
    end

    it "returns reservations if there are reservations for given room and date range" do
      @front_desk.add_reservation(@dates)
      expect(@front_desk.find_reservation_with(room: @room, date_range: @dates).sample).must_be_instance_of  Hotel::Reservation 
    end

    it "returns reservations if there are reservations for given date range" do
      @front_desk.add_reservation(@dates)
      expect(@front_desk.find_reservation_with(date_range: @dates).sample).must_be_instance_of  Hotel::Reservation 
    end

  end

  describe " total_cost" do

    it "calculates total cost of the reservation not in block " do
      new_reservation = @front_desk.add_reservation(@dates)
      expect(@front_desk.total_cost(new_reservation)).must_equal 800
    end

    it "calculates total cost of a reservation in a block " do
      block1 = @front_desk.request_block( @block_count, @dates, @discount_cost)
      block_reservation = @front_desk.add_reservation_to_room_in_block(block1)
      expect(@front_desk.total_cost(block_reservation)).must_equal 640

    end
  end

  describe "request_block" do

    it "reserves the correct number of rooms for the hotel block for given date range" do
      @front_desk.request_block( @block_count, @dates, @discount_cost)

      expect(@front_desk.hotel_blocks[0].rooms.count).must_equal 3
    
    end

    it " raises exception if there aren't enough rooms to fill block for given date range" do
      19.times do
        @front_desk.add_reservation(@dates)
      end

      expect{@front_desk.request_block(@block_count, @dates, @discount_cost)}.must_raise NoAvailableRoomError 

    end


    it "does not add room to a block for a given date range if that room is already in a block" do
      @front_desk.request_block( @block_count, @dates, @discount_cost)

      expect(@front_desk.request_block( @block_count, @dates, @discount_cost).rooms[0].room_number).must_equal 4
      expect(@front_desk.request_block( @block_count, @dates, @discount_cost).rooms[0].room_number).must_equal 7
      expect(@front_desk.request_block( @block_count, @dates, @discount_cost).rooms[0].room_number).must_equal 10
    
    end
  
  end

  describe "check_block_status" do

    it "deletes rooms in block from available rooms if there is overlap" do
      @front_desk.request_block( @block_count, @dates, @discount_cost)
      new_dates = Hotel::DateRange.new(start_date: Date.today + 6, end_date: Date.today + 10)

      expect(@front_desk.check_block_status(@dates).count).must_equal 17
      expect(@front_desk.check_block_status(new_dates).count).must_equal 20
  
    end
  end

  describe "available_rooms_in_block" do
    it "returns all rooms that are available for reservations" do
      block1 = @front_desk.request_block( @block_count, @dates, @discount_cost)
      expect(@front_desk.available_rooms_in_block(block1).count).must_equal 3
      expect(@front_desk.available_rooms_in_block(block1)[0].room_number).must_equal 1
      expect(@front_desk.available_rooms_in_block(block1)[1].room_number).must_equal 2
      expect(@front_desk.available_rooms_in_block(block1)[2].room_number).must_equal 3

      @front_desk.add_reservation_to_room_in_block(block1)
      expect(@front_desk.available_rooms_in_block(block1).count).must_equal 2
      expect(@front_desk.available_rooms_in_block(block1)[0].room_number).must_equal 2
      expect(@front_desk.available_rooms_in_block(block1)[1].room_number).must_equal 3
    end
  end

  describe "add_reservation_to_room_in_block" do
    it "adds a reservation to the first availavle room in the block" do
      block1 = @front_desk.request_block( @block_count, @dates, @discount_cost)
      @front_desk.add_reservation_to_room_in_block(block1)
      expect(block1.rooms[0].reservations[0].date_range).must_equal @dates
      
    end

    it "raises exception if there are no rooms left to add a reservation to" do
      block1 = @front_desk.request_block( @block_count, @dates, @discount_cost)
      3.times do
      @front_desk.add_reservation_to_room_in_block(block1)
      end
      expect{@front_desk.add_reservation_to_room_in_block(block1)}.must_raise NoAvailableRoomError
    end
  end
end