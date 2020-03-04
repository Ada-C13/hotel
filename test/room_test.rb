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
      [0, 21].each do |num|
        expect do
          Hotel::Room.new(num, 200, [])
        end.must_raise ArgumentError
      end
    end

    # don't think I need this anymore
    # it "stores a room_cost" do
    #   expect(@room.cost).must_equal @cost
    # end

    # will need to adjust this test if room cost can vary in future waves
    it "has a fixed cost of 200" do
      expect(@room.cost).must_equal 200
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

    # not sure if I need this test in this class?
    # it "throws an argument error if given an invalid reservation" do
    #   @room.add_room_reservation("invalid reservation")
    #   expect { @room.add_room_reservation("invalid reservation") }.must_raise ArgumentError
    #   expect(@room.rez_list.length).must_equal 0
    # end

  end
end
