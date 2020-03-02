require 'date'

module Hotel
  class DateRange
    attr_reader :check_in_time, :check_out_time, :days
    def initialize(check_in_time, check_out_time)
      @check_in_time = Date.new(check_in_time[0], check_in_time[1], check_in_time[2])
      @check_out_time = Date.new(check_out_time[0], check_out_time[1], check_out_time[2])
      @days = []

      if @check_in_time.class != Date
        raise ArgumentError, "The check in time #{check_in_time} is not a valid time."
      elsif @check_out_time.class != Date
        raise ArgumentError, "The check out time #{check_out_time} is not a valid time."
      elsif (@check_out_time <=> @check_in_time) <= 0
        raise ArgumentError, "The dates are not valid. Check in: #{@check_in_time}, Check out: #{@check_out_time}"
      else
        date = @check_in_time.clone
        until date === @check_out_time.next
          @days << date
          date = date.next
        end
      end
    end

    def nights
      return days.length - 1
    end
  end
end