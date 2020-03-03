require "date"

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date
    attr_reader :nights

    def initialize(start_date:, end_date:)
      if end_date != nil
        if end_date > start_date
          @start_date = start_date
          @end_date = end_date
        else
          raise ArgumentError, "Start date must be before end date"
        end
      end
      @nights = (@end_date - @start_date).to_i
    end
  end

  # def overlap?(other)
  # end

  # def include?(start_date, end_date)
  # end
end
