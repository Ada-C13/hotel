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

    def valid_date?(date)
      date_format = '%Y-%m-%d'
      DateTime.strptime(date, date_format)
      true
    rescue ArgumentError
      false
    end

    valid_date?(start_date)
    valid_date?(end_date)

    raise InvalidDateRangeError.new ("The given date range is invalid.") if (@end_date - @start_date) <= 0
  end

  def assign_room_number
    room_number = available_rooms[0]
    return room_number
  end
  
  def details
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