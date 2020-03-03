require_relative "test_helper"

describe "Room" do
  describe "Initialize" do
    it "Create instance of Room" do
      room = Hotel::Room.new(1)
      expect(room).must_be_kind_of Hotel::Room
    end    
  end
end