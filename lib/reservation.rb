require "date"

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room_id

    def initialize(room_id: , start_date:, end_date:)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @room_id = room_id
    end
  end




end