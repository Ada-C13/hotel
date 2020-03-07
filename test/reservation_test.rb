require_relative 'test_helper'

describe "reservation class" do 
  describe "initiative method" do 
    before do 
      @reservation = Hotel::Reservation.new(
        
      date_range: Hotel::DateRange.new(start_date:[2020,3,2],end_date:[2020,3,5])
      )
    end 
    it "is an instance of Reservation" do 
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end 
    it "date_range is instance of DateRange" do 
      expect(@reservation.date_range).must_be_instance_of Hotel::DateRange
      
    end 
  end  
end 