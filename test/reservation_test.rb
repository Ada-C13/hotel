require_relative 'test_helper'

describe Hotel::Reservation do
  
  before do 
    @date = Date.new(2020,05,01)
    start_date = @date
    end_date = start_date + 2
    @datarange =  Hotel::DateRange.new(start_date,end_date)
    @room = Hotel::Room.new(1)
    @reservation = Hotel::Reservation.new(@datarange, @room)
  end

  it "Returns the total_cost of the reservation" do
    cost = @reservation.total_cost
    expect(cost).must_be_close_to (200 * 2), 0.01
  end

end