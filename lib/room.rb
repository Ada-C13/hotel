# frozen_string_literal: true

require 'reservation'

class Room
  attr_accessor :reservations, :room_num
  def initialize(room_num)
    @room_num = room_num
  end

  def add_reservation
    Reservation.new(@room_num, start_date, end_date)
  end

  def find_all_resevations
    reservation_array = Reservation.all

    reservation_array.each do |reservation|
      return reservation if reservation.room_num == @room_num
    end
  end
end
