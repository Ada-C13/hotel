require_relative 'test_helper'

describe "Reservation class" do 
  
  # Arrange 
  before do 
    date_range = Hotel::DateRange.new("2020-3-20", "2020-3-27")

    room = {
      number: 5,
      vacancy: true
    }

    @reservation = Hotel::Reservation.new(date_range, room)
  end

  describe "#initialize" do 
    it "Creates date_range and room instances" do 
      expect(@reservation).must_respond_to :date_range
      expect(@reservation).must_respond_to :room

      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end 
  end 

  
   # I can get the total cost for a given reservation
   describe "#total_cost" do 
   it "Returns the total cost for a given reservation" do
     expect(@reservation.total_cost).must_be_instance_of Float

     expect(@reservation.total_cost).must_be_close_to (7 * 200.00), 0.01
   end 
 end 
end 