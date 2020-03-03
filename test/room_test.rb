require_relative 'test_helper'

describe "Room class" do
  describe "initialize" do 
    before do
      @room = Hotel::Room.new(
        room_num: 10

      )

      @cost = 200
      @date_range = []
    
    end #before do end
  
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "has a cost of 200" do
      expect(@cost).must_equal 200
    end

    it "has a room_num of 10" do
      expect(@room.room_num).must_equal 10
    end

    it 'has a date_range that is an array' do
      expect(@date_range).must_be_kind_of Array
    end

  end #describe initialize
end #Room class describe end



