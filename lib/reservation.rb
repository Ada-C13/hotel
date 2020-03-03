require 'date'
require_relative 'date_range'

module Hotel
  class Reservation < DateRange
    attr_reader :start_date, :end_date, :id, :total_cost, :room_number

    attr_accessor :nights

    def initialize(start_date, end_date)
      super(start_date, end_date)

      @id = id
      @total_cost = total_cost
      @nights = end_date - start_date
      @room_number = room_number
    end

  end
end