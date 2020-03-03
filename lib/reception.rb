module Hotel
  class Reception
    attr_reader :rooms, :reservations
    def initialize
      @rooms = []
      @reservations
      20.times do |i|
        i += 1
        @rooms << {room_id: i, cost: 200}
      end
    end
    def list_reservs_by_room_date(room_id, date)
      requested_date = Date.new(date[0], date[1], date[2])
      reservations.select { |reservation| reservation.room == room_id && reservation.date_range.days.include?(requested_date)}
    end
    def list_reservs_by_date
      
    end
    def find_reservation(id)
      return reservations.find { |reservations| reservations.id == id }
    end
  end
end