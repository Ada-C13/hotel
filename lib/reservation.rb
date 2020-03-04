
module Hotel
  class Reservation
    attr_reader :id, :room, :start_date, :end_date

    def initialize(id:, room:, start_date:, end_date:)
      @id = id
      @room = room
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end
  end
  
end