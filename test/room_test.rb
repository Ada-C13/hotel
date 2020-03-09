require_relative "test_helper"

describe "Room Class" do

  describe "initialize" do
    # Assumptions: default cost of room is $200.00 and there's only 20 rooms 
    it "creates an instance of Room object" do 
      @test_room = Hotel::Room.new(number: 1)
      expect(@test_room).must_be_kind_of Hotel::Room
    end 

    it "sets cost to 200.00 as default" do 
      @test_room = Hotel::Room.new(number: 1)
      expect(@test_room.cost).must_equal 200.00
    end 

    it "sets reservation_ids array to empty as default" do 
      @test_room = Hotel::Room.new(number: 1)
      expect(@test_room.reservation_ids.length).must_equal 0
    end 

    it "raises an error if valid room_id is not given" do
      expect{Hotel::Room.new(number: 0)}.must_raise ArgumentError
      expect{Hotel::Room.new(number: 100)}.must_raise ArgumentError
    end
  end 
  
end  
