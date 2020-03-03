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

end