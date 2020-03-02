require_relative 'room'

module Hotel
  class Reservation
    attr_reader :id, :room, :room_number, :guest, :start_date, :end_date

    def initialize(id, room_number, guest, start_date, end_date)
      @id = id
      @room_number = room_number
      @guest = guest
      @start_date = start_date
      @end_date = end_date
    end
  end
end