require_relative "test_helper"

describe "FrontDesk Class" do

  describe "initialize" do
    it "creates an instance of FrontDesk" do
      @test_desk = Hotel::FrontDesk.new()
      expect(@test_desk).must_be_kind_of Hotel::FrontDesk
    end 
    
    it "sets rooms list and reservations list to empty arrays as default" do 
      @test_desk = Hotel::FrontDesk.new()
      expect(@test_desk.rooms.length).must_equal 0 
      expect(@test_desk.reservations.length).must_equal 0 
    end 
  end 

  describe "update_room_list(room)" do 
    it "can add room objects to the @rooms array" do 
      @test_desk = Hotel::FrontDesk.new()
      @test_desk.update_room_list(Hotel::Room.new(number: 1))
      expect(@test_desk.rooms.length).must_equal 1
      expect(@test_desk.rooms[0]).must_be_kind_of Hotel::Room
    end 
  end

  describe "create_rooms" do 
    it "populates @rooms array with 20 room objects" do 
      @test_desk = Hotel::FrontDesk.new()
      @test_desk.create_rooms
      expect(@test_desk.rooms.length).must_equal 20
      expect(@test_desk.rooms[19]).must_be_kind_of Hotel::Room
      expect(@test_desk.rooms[19].number).must_equal 20
    end 
  end 

  describe "reservations_by_room_and_range(room_num, start_date, end_date)" do
  end

end  
