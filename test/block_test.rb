require_relative "test_helper"

describe Hotel::Block do
  before do
    @start_date = Date.new(2020,03,07)
    @end_date = @start_date + 5

    @collection_of_rooms = []
    [6,10,13,16].each do |room_num|
      @collection_of_rooms.push(Hotel::Room.new(room_num))
    end

    @room1 = Hotel::Room.new(1)
    @collection_of_rooms.push(@room1)

    @disc_rate = 0.2

    @hotel_block = Hotel::Block.new(@start_date,@end_date,@collection_of_rooms,@disc_rate)
    @hotel_block.reserve_room_from_block(@room1)
   
  end


  describe "initializes block correctly" do

    it "block can be succesfully created" do
      expect(@hotel_block).must_be_kind_of Hotel::Block
      expect(@hotel_block.start_date).must_equal @start_date
      expect(@hotel_block.end_date).must_equal @end_date
      expect(@hotel_block.available_rooms).must_equal @collection_of_rooms
      expect(@hotel_block.available_rooms).must_be_kind_of Array
      expect(@hotel_block.available_rooms[0]).must_be_kind_of Hotel::Room
      expect(@hotel_block.disc_rate).must_equal @disc_rate

    end

  end

  describe "reserve_room_from_block" do
    it "successfully reserves from block" do
      expect(@hotel_block.reserved_rooms[0]).must_equal @room1
      expect(@hotel_block.available_rooms.include?(@room1)).must_equal false
    end

    it "raises an exception if I try to reserve a room from the block that isn't available" do 
      expect{@hotel_block.reserve_room_from_block(@room1)}.must_raise RuntimeError
    end

  end


end