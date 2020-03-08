module Stayappy
  class Reservation
    attr_reader :room, :check_in, :check_out

    def initialize(room:, check_in:, check_out:)
      @room = room
      if check_in > check_out
        raise ArgumentError.new("Your check_out date must come after your check_in date")
      end
      @check_in = check_in
      @check_out = check_out
    end

    def stay()
      return @check_in..@check_out
    end
    
    def in_range?(start_date, end_date)
      # Permit start or end same as check_in or out
      if @check_in >= start_date && @check_in <= end_date
        return true
      elsif @check_out >= start_date && @check_out <= end_date
        return true
      end

      return false
    end

    def stay_overlaps?(other_check_in:, other_check_out:)
      # Ensure check_in does not overlap
      if other_check_in >= @check_in && other_check_in < @check_out
        return true
      elsif other_check_out > @check_in && other_check_out <= @check_out
        return true
      end

      return false
    end

  end
end