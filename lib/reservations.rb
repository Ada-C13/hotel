require 'date'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room, :id

    def initialize(id:, start_date:, end_date:, room: nil)
      @id = id
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @room = room
    end

  end
end