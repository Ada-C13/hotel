require_relative "test_helper"

describe "Reservation Class" do

  describe "initialize" do
    it "creates an instance of a Reservation object" do
      start_date = Date.new(2020, 8, 4)
      end_date = start_date + 5
      @test_reservation = Hotel::Reservation.new(id: 1, room_num: 1, start_date: start_date, end_date: end_date)
      expect(@test_reservation).must_be_kind_of Hotel::Reservation
    end
  end 
  
  describe "total_cost" do 
    it "calculates correct cost for number of nights" do 
      start_date = Date.new(2020, 8, 4)
      end_date = Date.new(2020, 8, 10)
      @test_reservation = Hotel::Reservation.new(id: 1, room_num: 1, start_date: start_date, end_date: end_date)
      expect(@test_reservation.total_cost).must_equal 1200.00
    end
  end 
end  
