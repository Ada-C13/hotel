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
      @nights = (@check_out - @check_in).to_i
    end
  end

  # Wave 2:

  # def overlap?(other)
  # end

  # def include?(check_in, check_out)
  # end
end

# research dates affordances - should I handle @nights differently? Generate an array of dates within daterange? what methods can I call on @nights to check for overlap and include?
