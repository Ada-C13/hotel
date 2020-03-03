require_relative 'test_helper'

describe "Reservation class" do
  before do
    @date = Hotel::DateRange.new(Date.new, Date.new + 2)
    @occupancy = {:room => Hotel::Room.new(12), :guest => "Picchu"}
    @reservation = Hotel::Reservation.new("single", @date, @occupancy)
  end
  describe "initializer" do
    
  end

  it "calculates total price" do
    expect(@reservation.total_price).must_equal (400) 
  end 
  
end