require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out, :nights_spent

    def initialize(check_in, check_out)
      raise ArgumentError, 'Invalid date range given.' unless check_out > check_in
      @check_in = check_in
      @check_out = check_out
      @nights_spent = (@check_out - @check_in) 
    end

    def to_id
      return (@check_in.year.to_s + @check_in.mon.to_s + @check_in.mday.to_s)
    end

    def overlap? (other_check_in, other_check_out)
      return ((@check_in..@check_out).cover? (other_check_in)) || ((@check_in-1...@check_out).cover? (other_check_out))
    end

  end
end