require 'date'
require 'securerandom'

require_relative 'room'

class Reservation
  attr_accessor :start_date, :end_date, :id, :cost, :room_number, :total_nights

  def initialize (start_date, end_date)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @id = (SecureRandom.alphanumeric).slice(0...7).upcase
    @cost = (@end_date - @start_date).to_i * 200
    @total_nights = (Date.parse(end_date) - Date.parse(start_date)).to_i
    @room_number = reservation.assign_room_number
  end

  
  def reservation_details(reservation)
    {
      :id => @id,
      :start_date => @start_date.iso8601, 
      :end_date => @end_date.iso8601, 
      :total_nights => @total_nights,
      :cost => @cost,
      :room_number => @room_number
    }
  end

end