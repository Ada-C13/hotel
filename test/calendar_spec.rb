require_relative '../lib/calendar'
require_relative '../lib/reservation'
require_relative 'test_helper'

describe "Can get the total cost by reservation ID" do
  before do 
    @reservation1 = Reservation.new("2020/05/04", "2020/05/07")
    @reservation2 = Reservation.new("2020/05/07", "2020/05/09")
    @reservation3 = Reservation.new("2020/05/06", "2020/05/11")

    @calendar = Calendar.new

    @calendar.add_to_calendar(@reservation1)
    @calendar.add_to_calendar(@reservation2)
    @calendar.add_to_calendar(@reservation3)
  end

  it "gives correct cost of requested reservation" do
    id = @reservation1.id
    cost = @calendar.total_cost_reservation(id)

    expect @reservation1.cost.must_equal cost
  end

  it "lists all reservations for specific date" do
    expected_outcome = [@reservation1]
    actual_outcome = @calendar.reservations_on_date("2020/05/04")
    expect actual_outcome == expected_outcome
  end 
end
    
