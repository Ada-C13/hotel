require_relative 'test_helper'

describe "Room Class" do
  describe "Room instantiation" do
    before do
      @room = Hotel::Room.new()
    end

    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end
  end

end