class Reservation
  attr_accessor :room_num,:start_date,:end_date
  def initialize(room_num,start_date,end_date)
    @room_num = room_num
    @start_date = start_date
    @end_date = end_date
  end
  def total
    # number of nights * $200/night - 1 night
  end
  
end