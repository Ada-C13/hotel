require_relative 'test_helper'

describe Hotel::Room do
  describe "initialize" do
    before do
      @room_id = 5
      @room = Hotel::Room.new(@room_id)

      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range_1 = Hotel::DateRange.new(@start_date, @end_date)
      @reservation_1 = Hotel::Reservation.new(@date_range_1, @room_id)
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "stores a room_id" do
      expect(@room.room_id).must_equal @room_id
    end

    it "has a room_id between 1-20" do
      [-1, 0, 21].each do |num|
        expect do
          Hotel::Room.new(num, 200, [])
        end.must_raise ArgumentError
      end
    end

    it "stores an array of Reservations" do
      expect(@room.rez_list).must_be_kind_of Array
    end

    it "stores an empty aray of Reservations upon initializing" do
      expect(@room.rez_list.length).must_equal 0
    end
  end

  describe "add_room_reservation" do
    before do
      @room_id = 5
      @room = Hotel::Room.new(@room_id)
      
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range_1 = Hotel::DateRange.new(@start_date, @end_date)
      @reservation_to_add = Hotel::Reservation.new(@date_range_1, @room_id)
    end

    it "correctly adds a reservation to the room's reservation list" do
      @date_range_2 = Hotel::DateRange.new(@start_date+1, @end_date+1)
      @reservation_to_add_2 = Hotel::Reservation.new(@date_range_2, @room_id)
      
      @room.add_room_reservation(@reservation_to_add)
      expect(@room.rez_list.length).must_equal 1

      @room.add_room_reservation(@reservation_to_add_2)
      expect(@room.rez_list.length).must_equal 2
    end
  end

  describe "conflict?" do
    before do
      @room_id = 5
      @room = Hotel::Room.new(@room_id)
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range_1 = Hotel::DateRange.new(@start_date, @end_date)
      @reservation_to_add = Hotel::Reservation.new(@date_range_1, @room_id)
      @room.add_room_reservation(@reservation_to_add)
    end

    it "returns true if the input range conflicts with the current reservation range" do
      date_range_2 = Hotel::DateRange.new(@start_date, @end_date)
      expect(@room.conflict?(date_range_2)).must_equal true
    end

    it "returns false if the input range does not conflict with the current reservation range" do
      date_range_3 = Hotel::DateRange.new(@start_date+3, @end_date+3)
      expect(@room.conflict?(date_range_3)).must_equal false
    end
  end

  describe "create_room_reservation" do
    before do
      @room_id = 5
      @room = Hotel::Room.new(@room_id)
      
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range_1 = Hotel::DateRange.new(@start_date, @end_date)
      @date_range_2 = Hotel::DateRange.new(@start_date+1, @end_date+1)
      @reservation_to_add = Hotel::Reservation.new(@date_range_1, @room_id)
    end

    it "returns false if input range conflicts with existing room reservations" do
      @room.create_room_reservation(@date_range_1)
      conflicting_date_range = Hotel::DateRange.new(@start_date, @end_date)
      expect(@room.create_room_reservation(conflicting_date_range)).must_equal false
    end
    
    it "creates a new Reservation if no range conflicts exist" do
      @room.create_room_reservation(@date_range_1)
      expect(@room.rez_list[0]).must_be_kind_of Hotel::Reservation

      expect(@room.rez_list[0].room_id).must_equal 5
      expect(@room.rez_list[0].date_range).must_equal @date_range_1
    end

    it "adds the newly created Reservation to rez_list" do
      expect(@room.rez_list.length).must_equal 0

      @room.create_room_reservation(@date_range_2)
      expect(@room.rez_list.length).must_equal 1
    end

    it "returns true if a new Reservation is created" do
      result = @room.create_room_reservation(@date_range_2)
      expect(result).must_equal true
    end
  end

  describe "find_by_range" do
    before do
      @room_id = 5
      @room = Hotel::Room.new(@room_id)
    
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 5)
      @date_range_1 = Hotel::DateRange.new(@start_date, @end_date)
      @date_range_2 = Hotel::DateRange.new(@start_date, @end_date-3)
      @date_range_3 = Hotel::DateRange.new(@start_date+1, @end_date-1)
      @date_range_4 = Hotel::DateRange.new(@start_date-3, @end_date-6)
      @reservation_to_add = Hotel::Reservation.new(@date_range_2, @room_id)
      @reservation_to_add_2 = Hotel::Reservation.new(@date_range_3, @room_id)
    end

    it "returns an array of Reservations" do
      @room.create_room_reservation(@date_range_3)
      expect(@room.find_by_range(@date_range_1)).must_be_kind_of Array
      expect(@room.find_by_range(@date_range_1)[0]).must_be_kind_of Hotel::Reservation
    end

    it "returns an empty array if no reservations overlap the given range" do
      @room.create_room_reservation(@date_range_1)
      expect(@room.find_by_range(@date_range_4)).must_be_empty
    end

    it "finds any/all Reservations that overlap with the given range" do
      @room.add_room_reservation(@reservation_to_add)
      expect(@room.find_by_range(@date_range_1)[0]).must_equal @reservation_to_add
      expect(@room.find_by_range(@date_range_1).length).must_equal 1

      @room.add_room_reservation(@reservation_to_add_2)
      expect(@room.find_by_range(@date_range_1)[1]).must_equal @reservation_to_add_2
      expect(@room.find_by_range(@date_range_1).length).must_equal 2
    end

    it "excludes Reservations that don't overlap with the given range" do
      @room.add_room_reservation(@reservation_to_add_2)
      expect(@room.find_by_range(@date_range_1).length).must_equal 1

      @room.create_room_reservation(@date_range_4)
      expect(@room.find_by_range(@date_range_1).length).must_equal 1
    end
  end
end