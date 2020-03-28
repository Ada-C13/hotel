require_relative 'test_helper'

describe "Reservation class" do 
  
  # Arrange 
  before do 
    date_range = Hotel::DateRange.new(Date.today, Date.today + 7)

    hotel_manager = Hotel::HotelManager.new()

    room_id = hotel_manager.available_room_ids(date_range)[0]
    room = hotel_manager.find_room_by_id(room_id)

    @reservation = Hotel::Reservation.new(date_range, room: room)
  end

  describe "#initialize" do 
    it "creates date_range, room instance, block" do 
      expect(@reservation).must_respond_to :date_range
      expect(@reservation).must_respond_to :room
      expect(@reservation).must_respond_to :block

      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
      expect(@reservation.room).must_be_kind_of Hotel::Room

      expect(@reservation.date_range.start_date).must_equal Date.today
      expect(@reservation.date_range.end_date).must_equal Date.today + 7
      expect(@reservation.room.id).must_equal 1
      expect(@reservation.block).must_be_nil
    end 
  end 


   # I can get the total cost for a given reservation
   describe "#individual_total_cost" do 
     it "returns the correct total cost for a given reservation" do
       expect(@reservation.individual_total_cost).must_be_instance_of Float

       expect(@reservation.individual_total_cost).must_be_close_to (7 * 200.00), 0.01
     end 
    end 

   describe "#block_total_cost" do 
     it "returns the correct total cost for a given block reservation" do 

       date_range = Hotel::DateRange.new(Date.today + 10, Date.today + 16)

       rooms = []
       5.times do |i|
        room = Hotel::Room.new(id: i + 1)
        rooms << room
       end 

       block = Hotel::Block.new(date_range, rooms: rooms)

       reservation = Hotel::Reservation.new(date_range, block: block) 

       expect(reservation.block_total_cost).must_be_close_to (160.00 * 5 * 6), 0.01   
     end 
   end 
end 