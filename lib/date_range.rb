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
      elsif (@check_out_time - @check_in_time) <= 0
        raise ArgumentError, "The dates are not valid. Check in: #{@check_in_time}, Check out: #{@check_out_time}"

      end

      # @days = create_days(@check_in_time, @check_out_time)
      # @duration = days.length
    end

    # def create_days
    #   # total_days = Array.new
    #   # if @check_in_time.next == @check_out_time
    #   #   total_days = [@check_in_time, @check_out_time]
    #   # end
    #   # #take the start and the end, if start.next.to_s is same as end.next.to_s, total_days gets [Date.new(start), Date.new(end)]. Else, do some logic to 
    #   # # return total_days
    #   # return total_days
    # end

    # def nights
    #   return duration - 1
    # end
  end
end