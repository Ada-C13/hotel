
class Reservation
  attr_accessor :room,:start_date,:end_date
  def initialize(room,start_date,end_date)
    @room = room
    @start_date = start_date
    @end_date = end_date
  end
  def total
    # take in the Room class add_res method 
    # converts date range into number of nights
# each night * $200 less the last night
    @room.add_reservation(start_date,end_date)
    date_range = end_date - start_date 
    num_of_nights = date_range.to_i - 1
    p num_of_nights = num_of_nights * 200
    return num_of_nights
  end
  
end