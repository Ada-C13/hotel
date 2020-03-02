require_relative 'test_helper'

describe "Room Class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new(1)
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "stores an id" do
      expect(@room.id).must_equal 1
    end

  end
end