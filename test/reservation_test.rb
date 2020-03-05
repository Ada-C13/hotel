require_relative 'test_helper'

describe "Reservation Class" do
  date_range = Hotel::DateRange.new((Date.today), (Date.today + 3))
  
  let (:reservation) {
    Hotel::Reservation.new(date_range,)
  }
  
  it "instantiates a reservation correctly" do
    expect(reservation).must_be_instance_of Hotel::Reservation
    expect(reservation.date_range).must_be_instance_of Hotel::DateRange
    expect(reservation.total_cost).must_equal 600
  end
  
  # TODO: think of some edge cases here - do other method validation methods catch edge cases?
end


describe "total cost" do
  it "calculates a single night's reservation cost" do

    date_range = Hotel::DateRange.new((Date.today), (Date.today + 1))

    reservation = Hotel::Reservation.new(date_range)

    expect(reservation.total_cost).must_equal 200
  end
  

  it "calculates multi-night reservation costs" do
    date_range = Hotel::DateRange.new((Date.today), (Date.today + 3))

    reservation = Hotel::Reservation.new(date_range) 

    expect(reservation.total_cost).must_equal 600
  end
end
