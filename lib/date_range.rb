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
          raise ArgumentError, "Those are invalid dates"
        end
      end
      @nights = self.nights
    end
  end

  # def overlap?(other)
  # end

  # def include?(start_date, end_date)
  # end

  def nights
    return (@end_date - @start_date) # is this right? -1 night?
  end
end
