require 'time'

module Hotel
  class Reservation
    attr_accessor :start_date, :end_date, :num_rooms, :assigned_room
    
    COST = 200

    def initialize(start_date:, end_date:, num_rooms:)
      @start_date = Time.parse(start_date)
      @end_date = Time.parse(end_date)
      @num_rooms = 1
      @assigned_room = nil

      if @start_date > @end_date || @start_date == @end_date
        raise ArgumentError.new("Invalid times: #{@start_date} comes after #{@end_date}")
      end
    end

    def total_cost
      days = ((@end_date - @start_date)/3600/24)*COST
      return days
    end

    def contains(date)
      if date >= @start_date && date < @end_date
        return true
      else
        return false
      end
    end

    def conflict?(new_start, new_end)
      if new_start >= @start_date && new_start < @end_date || new_end > @start_date
        return false
      elsif @end_date = new_start || new_start > @end_date || new_end < @start_date || new_end == @start_date
        return true
      end
    end
  end
end