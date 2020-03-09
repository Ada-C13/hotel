require 'date'
require 'securerandom'

require_relative 'room'


class Reservation
  attr_accessor :id, :start_date, :end_date, :total_nights, :cost, :room_number

  def initialize(start_date, end_date)
    @id = (SecureRandom.alphanumeric).slice(0...7).upcase
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @total_nights = (@end_date - @start_date).to_i
    @cost = @total_nights * 200
    @room_number = room_number
  end

  def assign_room_number(reservation)
    room = list_of_available_rooms_entire_stay(reservation)
    room_number = room[0]
    
    return room_number
  end
  
  def details
   return resdeets = {
      :id => @id,
      :start_date => @start_date.iso8601, 
      :end_date => @end_date.iso8601, 
      :total_nights => @total_nights,
      :cost => @cost,
      :room_number => @room_number
    }
  end

end