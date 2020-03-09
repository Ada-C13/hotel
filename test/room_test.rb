require_relative 'test_helper'

describe "Room class" do
  before do
    @room = Hotel::Room.new(1)
  end

  describe "initialize" do
    it "creates a valid room object" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end

  describe "Room methods" do
    it "sets price to 200" do
      expect(@room.price).must_equal 200
    end

    it "gives room a default type" do
      expect(@room.type).must_equal "standard"
    end
  end

end