require_relative 'test_helper'

describe "Room class" do
  describe "initialize" do 
    before do
      @room = Hotel::Room.new(
        room_num: 10,


      )
    end #before do end
  
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "has a cost of 200" do
      expect(@room.cost).must_equal 200
    end

    it "has a room_num of 10" do
      expect(@room.room_num).must_equal 10
    end

    it 'has a date_range that is an array' do
      expect(@room.date_range).must_be_kind_of Array
    end

    describe "date_range" do
      before do
        start_date= "March 1, 2019"
        end_date = "March 5, 2019"
        @room = Hotel::Room.new(
          room_num: 13,
          date_range: [start_date, end_date], 
        )
      end #before do end

      it "expect date_range to NOT be empty" do
        expect(@room.date_range.empty?).must_equal false
      end
      
    end

  end #describe initialize
end #Room class describe end



