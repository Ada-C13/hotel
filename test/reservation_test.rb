require_relative 'test_helper'

describe "Reservation Class" do
  date_range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-07"))
  
  let (:reservation) {
    Hotel::Reservation.new(1, date_range, "3")
  }
  
  it "instantiates a reservation correctly" do
    expect(reservation).must_be_instance_of Hotel::Reservation
    expect(reservation.reservation_id).must_equal 1
    expect(reservation.date_range).must_be_instance_of Hotel::DateRange
    expect(reservation.room_number).must_equal "3"
    expect(reservation.total_cost).must_equal 800
  end
  
  # TODO: think of some edge cases here - do other method validation methods catch edge cases?
end


describe "total cost" do
  it "calculates a single night's reservation cost" do
    date_range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-04"))
    reservation = Hotel::Reservation.new(1, date_range, "5")
    expect(reservation.total_cost).must_equal 200
  end
  
  it "calculates multi-night reservation costs" do
    date_range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-06"))
    reservation = Hotel::Reservation.new(1, date_range, "5") 
    expect(reservation.total_cost).must_equal 600
  end
end

describe "valid reservation id" do
  # TODO
  # it "raises argument error for reservation numbers that already exist" do
    
  # end
  
  it "raises an argument error for invalid reservation numbers" do
    date_range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-07"))
    
    expect{ Hotel::Reservation.new(0, date_range, "3") }.must_raise ArgumentError
  end
  
end