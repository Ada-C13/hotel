require "date"

module Hotel
  class Reservation
    attr_reader :date_range, :room_id

    def initialize(room_id: , start_date:, end_date:)
      @date_range = DateRange.new(start_date: start_date, end_date: end_date)
      @room_id = room_id
    end
  end

end