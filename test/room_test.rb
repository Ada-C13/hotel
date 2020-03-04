require_relative 'test_helper'

describe Hotel::Room do
  describe "initialize" do
    before do
      @room_id = 5
      @room = Hotel::Room.new(@room_id)
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

    it "stores an array of the right number of Reservations" do
      expect(@room.rez_list.length).must_equal 0
    end


  end
end
