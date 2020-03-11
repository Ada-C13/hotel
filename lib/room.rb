# require_relative 'date_range'
# require_relative 'reservation'

class Room < Date_Range
  # currently a room is only a room
  attr_accessor :reservations, :room_num

  def initialize(room_num)
    @room_num = room_num
    @reservations = []
  end

  def check_overlap_with_room_reservations(requested_date_range)
    # check if the check_in and check_out date overlaps with any other reservations for the room.
    # Return true if no reservation conflicts with the checkin and checkout date.
    if !@reservations.any? { |res| res.overlaps_in_reservations?(requested_date_range) }
      return true
    end
    return false
  end

  def create_new_reservation(check_in_date, check_out_date, hotel_block_reservation = false)
    new_res = Reservation.new(room_num, check_in_date, check_out_date, hotel_block_reservation)
    @reservations << new_res
    return new_res
  end
end
