require_relative 'test_helper'

describe "ReservationManager class" do
  
  describe "Initializer" do

    before do 
      @reservation_manager = Hotel::ReservationManager.new(20)
    end

    it "is an instance of ReservationManager" do
      expect(@reservation_manager).must_be_kind_of Hotel::ReservationManager
    end

    it "initializes correct number of rooms" do
      expect(@reservation_manager.rooms.length).must_equal 20
    end

    it "assigns an id to each room" do
      expect(@reservation_manager.rooms[1][:room_id]).must_be_kind_of String
    end

    it "initializes with zero reservations" do
      assert_nil(@reservation_manager.reservations)
    end
    
  end
end