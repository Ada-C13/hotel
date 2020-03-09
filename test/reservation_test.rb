require_relative 'test_helper'

describe "Reservation class" do
  before do
    @date = Hotel::DateRange.new(Date.new, Date.new + 2)
    @occupancy = [{:room => Hotel::Room.new(12), :guest => "Picchu"}]
    @reservation = Hotel::Reservation.new(:SINGLE, @date, @occupancy)
  end
  
  describe "initializer" do

    it "creates a valid Reservation" do
      expect(@reservation.id).must_be_kind_of String
      expect(@reservation.dates).must_be_kind_of Hotel::DateRange
    end
    
  end

  describe "total_price" do

    it "calculates total price on single room" do
      expect(@reservation.total_price).must_equal (400) 
    end 

    it "calculates total price of a block" do
      occupancy = [{:room => Hotel::Room.new(12), :guest => "Picchu"},{:room => Hotel::Room.new(14), :guest => "Elvy"}]
      reservation = Hotel::Reservation.new(:BLOCK, @date, occupancy)

      expect(reservation.total_price).must_equal (800)
    end

  end
  
end