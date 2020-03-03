# frozen_string_literal: true

require 'reservation'

class Room
  attr_accessor :reservations, :room_num
  def initialize(room_num)
    @room_num = room_num
  end

  # - Every room is identical, and a room always costs $200/night
  # - The last day of a reservation is the checkout day, so the guest should not be charged for that night
  def add_reservation
    Reservation.new(@room_num, start_date, end_date)
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
