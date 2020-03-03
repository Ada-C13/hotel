require "date"

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date:, end_date:)
      if end_date != nil
        if Date.parse(end_date) > Date.parse(start_date)
          @start_date = Date.parse(start_date)
          @end_date = Date.parse(end_date)
        else
          raise ArgumentError, "Those are invalid dates"
        end
      end

      # @nights = nights(start_date, end_date)
    end
  end

  # def overlap?(other)
  # end

  # def include?(start_date, end_date)
  # end

  # def nights(start_date, end_date)
  # end
end
