require 'test_helper'
require 'time'


describe "Receptionist class" do

  describe "Initializer" do
    before do
      @hotel = Hotel::Receptionist.new(rooms: Hotel::Room.list_of_rooms, reservations: [])
    end
    
    it "is an instance of FrontDesk" do
      p @hotel
        expect(@hotel).must_be_kind_of Hotel::Receptionist
    end

    it"must return a list of all its rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
    end
  end  
end