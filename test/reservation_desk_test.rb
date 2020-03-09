require_relative "test_helper"

describe "ReservationDesk class" do
  before do
    @reservation_desk = Hotel::ReservationDesk.new()
    #@reservation = Hotel::Reservation.new("2020-4-1", "2020-4-5")
  end

  describe "ReservationDesk instantiation" do
    it "is an instance of ReservationDesk" do
      expect(@reservation_desk).must_be_kind_of Hotel::ReservationDesk
    end
  end

  describe "rooms" do
    it "returns an array" do
      expect(@reservation_desk.rooms).must_be_kind_of Array
    end

    it "returns an array of Rooms" do
      expect(@reservation_desk.rooms[0]).must_be_kind_of Hotel::Room
      expect(@reservation_desk.rooms.last).must_be_kind_of Hotel::Room
    end

    it "includes 20 rooms by default" do
      expect(@reservation_desk.rooms.length).must_equal 20
    end

    it "the first room has an id of 1" do
      expect(@reservation_desk.rooms[0].id).must_equal 1
    end

    it "the last room has an id which is equal to the number of rooms" do
      reservation_desk = Hotel::ReservationDesk.new(room_num: 134)
      expect(reservation_desk.rooms.last.id).must_equal 134
    end
  end

  describe "find_room_by_id" do
    it "returns an instanse of Room" do
      expect(@reservation_desk.find_room_by_id(2)).must_be_kind_of Hotel::Room
    end

    it "returns a Room with a matching ID" do
      expect(@reservation_desk.find_room_by_id(2).id).must_equal 2
    end

    it "returns nill if there is no Room with a matching ID" do
      assert_nil @reservation_desk.find_room_by_id(20000000)
   end
  end

  describe "find_reservations" do
    before do
      @reservation_desk.rooms[0].reserve(start_date: "2020-3-1", end_date: "2020-3-5")
      @reservation_desk.rooms[1].reserve(start_date: "2020-3-1", end_date: "2020-3-10")
      @reservation_desk.rooms[2].reserve(start_date: "2020-3-1", end_date: "2020-3-25")
      @reservation_desk.rooms[0].reserve(start_date: "2020-3-10", end_date: "2020-3-15")

    end

    it "returns an array" do
      result = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-3-1", end_date: "2020-3-17")
      expect(result).must_be_kind_of Array
    end

    it "returns an array of reservations" do
      result = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-3-1", end_date: "2020-3-17")
      expect(result[0]).must_be_kind_of Hotel::Reservation
    end

    it "ID provided: returns nil if room ID doesn't exist" do
      assert_nil @reservation_desk.find_reservations(room_id: 100000, start_date: "2020-3-1", end_date: "2020-3-17")
    end

    it "ID provided: returns reservations for requested dates" do
      result_1 = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-3-1", end_date: "2020-3-17")
      expect(result_1.length).must_equal 2
      result_2 = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-3-1", end_date: "2020-3-10")
      expect(result_2.length).must_equal 1
      result_3 = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-3-3", end_date: "2020-3-8")
      expect(result_3.length).must_equal 1
      result_4 = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-3-11", end_date: "2020-3-13")
      expect(result_4.length).must_equal 1
    end

    it "No ID provided: returns reservations for specific dates for all rooms" do
      @reservation_desk.rooms[3].reserve(start_date: "2020-3-1", end_date: "2020-3-5")
      @reservation_desk.rooms[4].reserve(start_date: "2020-3-10", end_date: "2020-3-15")
      @reservation_desk.rooms[5].reserve(start_date: "2020-3-20", end_date: "2020-3-25")
      @reservation_desk.rooms[6].reserve(start_date: "2020-5-20", end_date: "2020-5-25")

      result = @reservation_desk.find_reservations(start_date: "2020-3-1", end_date: "2020-3-30")
      expect(result.length).must_equal 7
    end

    it "takes into account reservertions from a block" do
      @reservation_desk.make_block(room_ids:[7, 8, 9], start_date: "2020-3-4", end_date: "2020-3-8")
      @reservation_desk.reserve_from_block(block_id: 1, room_id: 9)

      result = @reservation_desk.find_reservations(room_id: 9, start_date: "2020-3-1", end_date: "2020-3-30")
      expect(result.length).must_equal 1

      result_2 = @reservation_desk.find_reservations(start_date: "2020-3-1", end_date: "2020-3-30")
      expect(result_2.length).must_equal 5
    end

    it "No ID provided: returns empty array if there are no reservations for the room/dates" do
      result = @reservation_desk.find_reservations(room_id: 1, start_date: "2020-4-1", end_date: "2020-4-17")
      expect(result.length).must_equal 0
    end
  end

  describe "find_available_rooms" do
    before do
      @reservation_desk.rooms[0].reserve(start_date: "2020-3-1", end_date: "2020-3-5")
      @reservation_desk.rooms[1].reserve(start_date: "2020-3-1", end_date: "2020-3-10")
      @reservation_desk.rooms[2].reserve(start_date: "2020-3-1", end_date: "2020-3-25")

      @request = @reservation_desk.find_available_rooms(start_date: "2020-2-27", end_date: "2020-4-2")
    end

    it "returns an Array" do
      expect(@request).must_be_kind_of Array
    end

    it "returns an Array of Rooms" do
      expect(@request[0]).must_be_kind_of Hotel::Room
    end

    it "returns an array of Rooms which don't have Reservations for requested dates" do
      expect(@request.length).must_equal 17
      expect(@request[0].id).must_equal 4
    end

    it "returns nil if there are no Rooms available for requested dates" do
      @reservation_desk.rooms.each do |room|
        room.reserve(start_date: "2020-6-1", end_date: "2020-6-30")
      end
      search = @reservation_desk.find_available_rooms(start_date: "2020-6-5", end_date: "2020-6-10")
      assert_nil search
    end
  end

  describe "make_reservation" do
    it "ID provided: makes a new reservation and add it into the Room's reservations array" do
      @reservation_desk.make_reservation(room_id: 5, start_date: "2020-5-5", end_date: "2020-5-7")
      @reservation_desk.make_reservation(room_id: 5, start_date: "2020-6-5", end_date: "2020-6-7")
      expect(@reservation_desk.rooms[4].reservations.length).must_equal 2
      expect(@reservation_desk.rooms[4].available?(start_date: "2020-5-5", end_date: "2020-5-6")).must_equal false
    end

    it "ID provided: Raises an ArgumentError if ID is invalid" do
      expect {
        @reservation_desk.make_reservation(room_id: 999999, start_date: "2020-5-5", end_date: "2020-5-7")
      }.must_raise ArgumentError
    end

    it "No ID provided: reserves the first available room down the list for requested dates" do
      @reservation_desk.rooms[0].reserve(start_date: "2020-3-1", end_date: "2020-3-5")
      @reservation_desk.rooms[1].reserve(start_date: "2020-3-1", end_date: "2020-3-10")

      @request = @reservation_desk.make_reservation(start_date: "2020-3-4", end_date: "2020-3-15")
      expect(@reservation_desk.rooms[2].reservations.length).must_equal 1
      expect(@reservation_desk.rooms[2].available?(start_date: "2020-3-1", end_date: "2020-3-5")).must_equal false
    end

    it "No ID provided: raises an Exception if no rooms are available for requested dates" do
      20.times do
        @reservation_desk.make_reservation(start_date: "2020-6-1", end_date: "2020-6-30")
      end
      expect {
        @reservation_desk.make_reservation(start_date: "2020-6-1", end_date: "2020-6-30")
      }.must_raise StandardError
    end

    it "reserves a room at a default rate if no other specified" do
      @reservation_desk.make_reservation(room_id: 1, start_date: "2020-5-5", end_date: "2020-5-7")
      rate = @reservation_desk.rooms[0].reservations[0].rate
      expect(rate).must_equal 200
    end

    it "reserves a room at a specified rate" do
      @reservation_desk.make_reservation(room_id: 1, start_date: "2020-5-5", end_date: "2020-5-7", rate: 310.05)
      rate = @reservation_desk.rooms[0].reservations[0].rate
      expect(rate).must_equal 310.05
    end
  end

  describe "make_block" do
    it "Room IDs provided: it creates Reservations and adds them to requested rooms' block_participation array" do
      @reservation_desk.make_block(room_ids: [1, 2, 3], start_date: "2020-9-1", end_date: "2020-9-10")
      expect(@reservation_desk.rooms[0].block_participation.length).must_equal 1
      expect(@reservation_desk.rooms[1].block_participation.length).must_equal 1
      expect(@reservation_desk.rooms[2].block_participation.length).must_equal 1
      expect(@reservation_desk.rooms[3].block_participation.length).must_equal 0
    end

    it "Rooms IDs provided: it adds block information to the block hash" do
      @reservation_desk.make_block(room_ids: [1, 2, 3], start_date: "2020-9-1", end_date: "2020-9-10")
      expect(@reservation_desk.blocks.length).must_equal 1
      expect(@reservation_desk.blocks[1][:rooms].length).must_equal 3
      expect(@reservation_desk.blocks[1][:rooms][0]).must_be_kind_of Hotel::Room
    end

    it "Rooms IDs provided: raises an ArgumentError if any of IDs are invalid" do
      expect {
        @reservation_desk.make_block(room_ids: [1, 2, "love"], start_date: "2020-9-1", end_date: "2020-9-10")
      }.must_raise ArgumentError
    end

    it "Rooms IDs provided: raises ArgumentError if the room_ids array includes more then 5 rooms" do
      expect {
        @reservation_desk.make_block(room_ids: [1, 2, 3, 4, 5, 6], start_date: "2020-9-1", end_date: "2020-9-10")
      }.must_raise ArgumentError
    end

    it "Rooms IDs provided: it raises an Exception if any of the rooms are unavailable on requested dates" do
      @reservation_desk.make_reservation(start_date: "2020-10-1", end_date: "2020-10-5")
      
      expect {
        @reservation_desk.make_block(room_ids: [4, 5, 6, 7, 1], start_date: "2020-10-2", end_date: "2020-10-16")
      }.must_raise StandardError

      @reservation_desk.make_block(room_ids: [1, 2, 3], start_date: "2020-9-1", end_date: "2020-9-10")

      expect {
        @reservation_desk.make_block(room_ids: [4, 5, 6, 7, 1], start_date: "2020-9-2", end_date: "2020-9-5")
      }.must_raise StandardError
    end

    it "creates reservations with default rate if no discount specified" do
      @reservation_desk.make_block(room_ids: [1, 2, 3], start_date: "2020-9-1", end_date: "2020-9-10")
      rate = @reservation_desk.rooms[0].block_participation[0].rate
      expect(rate).must_equal 200
    end

    it "creates reservations with a different rate if specified" do
      @reservation_desk.make_block(room_ids: [1, 2, 3], start_date: "2020-9-1", end_date: "2020-9-10", rate: 150)
      rate = @reservation_desk.rooms[0].block_participation[0].rate
      expect(rate).must_equal 150
    end
  end

  describe "reserve_from_block" do
    before do
      @reservation_desk.make_block(room_ids: [1, 2, 3, 4], start_date: "2020-9-1", end_date: "2020-9-10")
      @reservation = @reservation_desk.reserve_from_block(room_id: 2, block_id: 1)
    end
    
    it "returns true if reservation was successful" do
      expect(@reservation).must_equal true
    end

    it "raises ArgumentError if room ID was not valid or wasn't part of the block" do
      expect {
        @reservation_desk.reserve_from_block(room_id: 6, block_id: 1)
      }.must_raise ArgumentError
    end

    it "raises ArgumentError if the block ID is invalid" do
      expect {
        @reservation_desk.reserve_from_block(room_id: 6, block_id: 1000)
      }.must_raise ArgumentError
    end

    it "raises StandardError if the room has already been reserved" do
      expect {
        @reservation_desk.reserve_from_block(room_id: 2, block_id: 1)
      }.must_raise StandardError
    end

    it "adds the original block reservation for the room to reservations array" do
      expect(@reservation_desk.rooms[0].reservations.length).must_equal 0
      @reservation_desk.reserve_from_block(room_id: 1, block_id: 1)
      expect(@reservation_desk.rooms[0].reservations.length).must_equal 1
    end
  end

  describe "check_block_availability" do
    before do
      @reservation_desk.make_block(room_ids: [1, 2, 3, 4, 5], start_date: "2020-9-1", end_date: "2020-9-10")
      @reservation_desk.reserve_from_block(room_id: 3, block_id: 1)
    end

    it "returns an Array" do
      expect(@reservation_desk.check_block_availability(1)).must_be_kind_of Array
    end

    it "returns an array of unreserved rooms in requested block" do
      expect(@reservation_desk.check_block_availability(1).length).must_equal 4
    end

    it "returns empty array if no rooms are available" do
      @reservation_desk.reserve_from_block(room_id: 1, block_id: 1)
      @reservation_desk.reserve_from_block(room_id: 2, block_id: 1)
      @reservation_desk.reserve_from_block(room_id: 4, block_id: 1)
      @reservation_desk.reserve_from_block(room_id: 5, block_id: 1)
      expect(@reservation_desk.check_block_availability(1).empty?).must_equal true
    end

    it "throws an ArgumentError if there is no block with a given ID" do
      expect { 
        @reservation_desk.reserve_from_block(room_id: 1, block_id: 2)
      }.must_raise ArgumentError

      expect { 
        @reservation_desk.reserve_from_block(room_id: 1, block_id: "Nataliya")
      }.must_raise ArgumentError
    end
  end
end