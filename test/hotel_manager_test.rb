require_relative 'test_helper'

describe "HotelManager class" do 

  # Arrange 
  before do 
     @hotel_manager = Hotel::HotelManager.new()

     @date_range = Hotel::DateRange.new("2020-3-20", "2020-3-27")
     @date_range_2 =  Hotel::DateRange.new("2020-3-5", "2020-3-10")
  end 


  describe "#initialize" do 
    # I can access the list of all of the rooms in the hotel
    it "Creates rooms" do
      # Assert
      expect(@hotel_manager).must_respond_to :rooms

      expect(@hotel_manager.rooms).must_be_instance_of Array

      @hotel_manager.rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end  
    end 

    # I access the list of reservations for a specified room and a given date range
    it "Creates reservations" do 
  
      expect(@hotel_manager).must_respond_to :reservations

      expect(@hotel_manager.reservations).must_be_instance_of Array   
      
      @hotel_manager.reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end 
    end 
  end 
end 

  