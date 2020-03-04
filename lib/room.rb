
require_relative 'reservation'

class Room
  attr_accessor :reservations, :room_num
  def initialize(room_num)
    @room_num = room_num
    @reservations = []
  end

  # - Every room is identical, and a room always costs $200/night
  # - The last day of a reservation is the checkout day, so the guest should not be charged for that night
  def add_reservation(start_date, end_date)
     new_res = Reservation.new(self, start_date, end_date)
     @reservations << new_res
     return new_res
  end


  def find_all_resevations
    reservation_array = Reservation.all
    reservation_array.each do |reservation|
      return reservation if reservation.room_num == @room_num
    end
  end

  def find_room_number
  end
end
