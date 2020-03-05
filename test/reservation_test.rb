require_relative 'test_helper'

describe "Reservation class" do 
  
  # Arrange 
  before do 
    date_range = Hotel::DateRange.new(Date.new(2020, 3, 20), Date.new(2020, 3, 27))

    hotel_manager = Hotel::HotelManager.new()

    room_number = hotel_manager.available_room_numbers(date_range)[0]
    room = hotel_manager.find_room_by_number(room_number)

    @reservation = Hotel::Reservation.new(date_range, room)
  end

  describe "#initialize" do 
    it "creates date_range and room instances" do 
      expect(@reservation).must_respond_to :date_range
      expect(@reservation).must_respond_to :room

      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
      expect(@reservation.room).must_be_kind_of Hotel::Room

      expect(@reservation.date_range.start_date).must_equal Date.new(2020, 3, 20)
      expect(@reservation.date_range.end_date).must_equal Date.new(2020, 3, 20) + 7
      expect(@reservation.room.number).must_equal 1
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