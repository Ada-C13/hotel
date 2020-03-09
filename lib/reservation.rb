require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date
    def initialize(start_date, end_date)
        @start_date = start_date
        @end_date = end_date
    end

    def cost
      cost = (@end_date - @start_date) * 200
      return cost
    end
  end
end