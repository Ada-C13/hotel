require_relative 'test_helper'

describe Hotel::Room do
  before do
    @room_id = 10
    @room01 = Hotel::Room.new(@room_id)
  end

  describe "#initialize" do
    it "is an instance of Room" do
      expect(@room01).must_be_instance_of Hotel::Room
    end

    it "stores a room_id as id" do
      expect(@room01.id).must_equal @room_id
    end

    it "raises ArgumentError if the room_id is not an integer within 1~20" do
      expect{Hotel::Room.new(38)}.must_raise ArgumentError
      expect{Hotel::Room.new(-10)}.must_raise ArgumentError
      expect{Hotel::Room.new("suite")}.must_raise ArgumentError
    end

    it "stores a cost for the room instance" do
      expect(@room01.cost).must_equal 200
    end

  end
end