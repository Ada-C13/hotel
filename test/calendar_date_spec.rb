require_relative 'test_helper'

describe "Manages calendar and it's various duties" do
  before do 
    @reservation1 = Reservation.new("2020/05/04", "2020/05/07")
    @reservation2 = Reservation.new("2020/05/07", "2020/05/09")
    @reservation3 = Reservation.new("2020/05/06", "2020/05/11")

    @calendar = Calendar.new
    
    @calendar.add_to_calendar(@reservation1)
    @calendar.add_to_calendar(@reservation2)
    @calendar.add_to_calendar(@reservation3)
  end

  it "has an array that keeps track of the available rooms" do
    
    hopefully_an_array = @date_store[Date.parse("2020/05/04").iso8601].all_available_rooms

    expect hopefully_an_array.must_be_instance_of Array
  end
end