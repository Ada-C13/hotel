require "date"

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = start_date
      @end_date = end_date
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
