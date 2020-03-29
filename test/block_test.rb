require_relative "test_helper"

describe "Block class" do
  before do
    @date_range = Hotel::DateRange.new(Date.today + 10, Date.today + 15)

    rooms = []

    3.times do |i|
      room = Hotel::Room.new(num: i + 1)
      rooms << room
    end

    @block = Hotel::Block.new(date_range: @date_range, rooms: rooms)
  end

  describe "#initialize" do
    it "creates an id, date_range, rooms, discount_rate, available_rooms, reserved_rooms" do
      expect(@block).must_respond_to :id
      expect(@block).must_respond_to :date_range
      expect(@block).must_respond_to :rooms
      expect(@block).must_respond_to :discount_rate
      expect(@block).must_respond_to :available_rooms
      expect(@block).must_respond_to :reserved_rooms

      expect(@block.id.length).must_equal 16
      expect(@block.date_range).must_be_kind_of Hotel::DateRange
      expect(@block.date_range.start_date).must_be_kind_of Date
      expect(@block.date_range.end_date).must_be_kind_of Date

      expect(@block.rooms).must_be_kind_of Array

      expect(@block.rooms.length).must_equal 3

      @block.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end
  end


  describe "#total_cost (block)" do
    it "returns the correct total cost for a given block reservation" do
      date_range = Hotel::DateRange.new(Date.today + 10, Date.today + 16)

      rooms = []
      5.times do |i|
        room = Hotel::Room.new(num: i + 1)
        rooms << room
      end

      block = Hotel::Block.new(date_range: date_range, rooms: rooms)

      expect(block.total_cost).must_be_close_to (160.00 * 5 * 6), 0.01
    end

    it "applies the correct discount rate" do 

      date_range = Hotel::DateRange.new(Date.today + 10, Date.today + 16)

      room_7 = Hotel::Room.new(num: 7)
      room_8 = Hotel::Room.new(num: 8)

      block = Hotel::Block.new(date_range: date_range, rooms: [room_7, room_8], discount_rate: 0.5)

      expect(block.total_cost).must_be_close_to (100.00 * 2 * 6), 0.01
    end 
  end
  

  describe "#reserve_room" do
    it "reserves a room in a block" do
      hotel_manager = Hotel::HotelManager.new()

      hotel_manager.reserve_block(date_range: @date_range, room_qty: 5)

      expect(@block.reserve_room).must_equal true
    end

    it "raises NoRoomError if there is no available room in a block" do
      hotel_manager = Hotel::HotelManager.new()
      date_range = Hotel::DateRange.new(Date.today, Date.today + 5)
      
      block = hotel_manager.reserve_block(date_range: date_range, room_qty: 5)

      5.times do 
        block.reserve_room
      end 

      expect{block.reserve_room}.must_raise Hotel::NoRoomError
    end
  end
end
