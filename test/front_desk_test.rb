require_relative 'test_helper'
describe "front_desk" do 
  def hotel_manager 
    return Hotel::FrontDesk.new()
  end 
  describe "reservation_cost method" do 
    it "calculate cost for a reservation" do 
      manager = hotel_manager
      reservation_1 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,2],end_date:[2020,3,5]
        )
      )
      reservation_2 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,4,1],end_date:[2020,4,8]
        )
      )
  
      manager.reservations << reservation_1
      manager.reservations << reservation_2
      cost = manager.reservation_cost(reservation_1)
      expect(cost).must_equal 600
      cost2 = manager.reservation_cost(reservation_2)
      expect(cost2).must_equal 1400
    end 




  end  
end 