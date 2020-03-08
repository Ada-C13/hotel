require_relative "test_helper"

describe Hotel::Block do
  before do
    @start_date = Date.new(2020,03,07)
    @end_date = @start_date + 5

    @collection_of_rooms = []
    [6,10,13,16].each do |room_num|
      @collection_of_rooms.push(Hotel::Room.new(room_num))
    end

    @disc_rate = 0.2

    @hotel_block = Hotel::Block.new(@start_date,@end_date,@collection_of_rooms,@disc_rate)   
  end


  describe "initializes block correctly" do

    it "block can be succesfully created" do
      expect(@hotel_block).must_be_kind_of Hotel::Block
    end

  end


end