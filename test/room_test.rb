require_relative 'test_helper.rb'

describe "room class" do
  before do
    @room = Stayappy::Room.new(room_num: 1, cost: 200)
  end

  describe "Initialize" do
    it "can create a room" do
      expect(@room).must_be_instance_of Stayappy::Room
    end

    it "sets the room number" do
      expect(@room.room_num).must_equal 1
    end

    it "sets the cost" do
      expect(@room.cost).must_equal 200
    end
  end
end
