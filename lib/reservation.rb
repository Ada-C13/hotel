require "date"

module Hotel
  class Reservation
    attr_reader :date_range, :room_id, :rate

    def initialize(room_id: , start_date:, end_date:, rate: :default)
      unless (rate == :default || rate.respond_to?(:>) && rate >= 0)
        raise ArgumentError.new("Invalid rate.") 
      end

      @date_range = DateRange.new(start_date: start_date, end_date: end_date)
      @room_id = room_id
      @rate = (rate == :default) ? 200 : rate
    end

    def cost
      date_range.nights * rate
    end
  end
end

