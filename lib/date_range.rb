require 'date'

module Hotel
  class DateRange
    attr_reader :check_in_time, :check_out_time
    def initialize(check_in_time, check_out_time)
      @check_in_time = Date.new(check_in_time[0], check_in_time[1], check_in_time[2])
      @check_out_time = Date.new(check_out_time[0], check_out_time[1], check_out_time[2])

      if @check_in_time.class != Date
        raise ArgumentError, "The check in time #{check_in_time} is not a valid time."
      elsif @check_out_time.class != Date
        raise ArgumentError, "The check out time #{check_out_time} is not a valid time."
      elsif (@check_out_time <=> @check_in_time) <= 0
        raise ArgumentError, "The dates are not valid. Check in: #{@check_in_time}, Check out: #{@check_out_time}"
      end
    end

    def include?(date)
      return self.create_days_array.include?(date)
    end

    def overlap?(date_range)

    end

    def nights
      return self.create_days_array.length - 1
    end

    def create_days_array
      days = []
      days_in_range = check_in_time.clone
        until days_in_range === check_out_time.next
          days << days_in_range
          days_in_range = days_in_range.next
        end
      return days
    end
  end
end