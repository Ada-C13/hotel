require_relative 'test_helper'

describe "Room Class" do
  before do
    @room = Hotel::Room.new(1, 200)
  end
  
  describe "Room Instantiation" do    
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
    end

    it "validates room number" do
      expect{Hotel::Room.new("1A", 200)}.must_raise ArgumentError
    end

    it "validates room price" do
      expect{Hotel::Room.new(1, "100")}.must_raise ArgumentError
    end
  end #initialize

  describe "load_all_rooms method test" do
    it "loads correct number of rooms" do
      expect(Hotel::Room.load_all_rooms().length).must_equal 20
    end
  end
end #class
