require_relative 'test_helper.rb'

describe "room class" do
  before do
    @room = Stayappy::Room.new(room_num: 1, cost: 200)
  end

  describe "Initialize" do
    it "can create an instance of room" do
      expect(@room).must_be_instance_of Stayappy::Room
    end

    it "can assign the room number" do
      expect(@room.room_num).must_equal 1
    end

    it "can set the cost" do
      expect(@room.cost).must_equal 200
    end
  end
end
