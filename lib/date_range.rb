require 'date'

module Hotel
  class DateRange
    attr_reader :check_in_time, :check_out_time
    def initialize(check_in_time, check_out_time)
      @check_in_time = check_in_time
      @check_out_time = check_out_time

      if @check_in_time.class != Date
        raise ArgumentError, "The check in time #{check_in_time} is not a valid time."
      elsif @check_out_time.class != Date
        raise ArgumentError, "The check out time #{check_out_time} is not a valid time."
      elsif (@check_out_time <=> @check_in_time) <= 0
        raise ArgumentError, "The dates are not valid. Check in: #{@check_in_time}, Check out: #{@check_out_time}"
      end
    end

    def create_days_array
      days = []
      days_in_range = @check_in_time.clone
      until days_in_range === @check_out_time.next
        days << days_in_range
        days_in_range = days_in_range.next
      end
      return days
    end

    def include?(date)
      return self.create_days_array.include?(date)
    end

    def overlap?(other_date_range)
      days = self.create_days_array
      other_days = other_date_range.create_days_array
    
      return false if (days.first === other_days.last || days.last === other_days.first) || days.difference(other_days).length === days.length
      return true
    end

    def nights
      return self.create_days_array.length - 1
    end
  end
end