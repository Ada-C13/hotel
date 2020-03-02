require_relative 'date_range'

module Hotel
  class Reservation < DateRange
    attr_reader :start_date, :end_date, :room

    def initialize(start_date, end_date)
      super(start_date, end_date)
      @room
    end
  end
end