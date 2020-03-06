# require_relative 'reservation'

class Room
  # currently a room is only a room
  attr_accessor :reservations, :room_num

  def initialize(room_num)
    @room_num = room_num
    @reservations = []
  end
end

def create_new_reservation
  new_res = Reservation.new(room_num, check_in_date, check_out_date)
  @reservations << new_res
  return new_res
end