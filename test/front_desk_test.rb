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

  describe "list_all" do
    it "return a list of all reservations" do 
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
      result = manager.list_all
      expect(result).must_match (/2020-03-02/)
      expect(result).must_match (/2020-03-05/)
      expect(result).must_match (/2020-04-01/)
      expect(result).must_match (/2020-04-08/)
    end 
  end
  
  describe "check_date_reservations method" do 
    it "return a list of all reservations under a specific date" do 
      manager = hotel_manager
      reservation_1 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,2],end_date:[2020,3,10]
        )
      )
      reservation_2 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,4,1],end_date:[2020,4,8]
        )
      )
      reservation_3 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,3],end_date:[2020,3,7]
        )
      )
      reservation_4 = Hotel::Reservation.new(
        date_range: Hotel::DateRange.new(
          start_date:[2020,3,4],end_date:[2020,3,5]
        )
      )
      manager.reservations << reservation_1
      manager.reservations << reservation_2
      manager.reservations << reservation_3
      manager.reservations << reservation_4

      date_to_check = [2020,3,5]
      result = manager.check_date_reservations(date_to_check)

      expect(result).must_match (/2020-03-02/)
      expect(result).must_match (/2020-03-10/)
      expect(result).must_match (/2020-03-03/)
      expect(result).must_match (/2020-03-07/)
      expect(result).wont_match (/2020-03-04/)
      expect(result).wont_match (/2020-03-05/)
      expect(result).wont_match (/2020-04-01/)
      expect(result).wont_match (/2020-04-08/)

    end 
  end 
  
end 