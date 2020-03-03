require_relative 'test_helper'

describe Hotel::Reservation do
  
  before do 
    @date = Date.parse("2020-05-21")
    start_date = @date
    end_date = start_date + 2
    datarange =  Hotel::DateRange.new(start_date,end_date)
    @reservation = Hotel::Reservation.new(datarange,nil)
  end


  it "Returns the total_cost of the reservation" do
    

  end

end