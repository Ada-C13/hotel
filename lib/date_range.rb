require "date"

module Hotel
  class DateRange
    attr_accessor :check_in, :check_out
    attr_reader :nights

    def initialize(check_in:, check_out:)
      if check_out != nil
        if check_out > check_in
          @check_in = check_in
          @check_out = check_out
        else
          raise ArgumentError, "Start date must be before end date"
        end
      end
      @nights = (@check_out - @check_in).to_i # change to array of each day with .length?
    end
  end

  # Wave 2:

  def self.overlap?(new_date_range) # for all schedule conflict cases
    case new_date_range
      # when new start date is inside range
    when new_date_range.check_in >= self.check_in && new_date_range.check_in < self.check_out
      return true
      # when new end date is inside range
    when new_date_range.check_out > self.check_in && new_date_range.check_out <= self.check_out
      return true
      # when new dates encompass range
    when new_date_range.check_in < self.check_in && new_date_range > self.check_out
      return true
    end
  end

  # def include?(one_day) 
  # end
end

# research dates affordances - should I handle @nights differently? Generate an array of dates within daterange? what methods can I call on @nights to check for overlap and include?
