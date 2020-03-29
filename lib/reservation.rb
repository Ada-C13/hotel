require "securerandom"

module Hotel
  class Reservation
    attr_reader :id, :date_range, :rooms

    def initialize(id: nil, date_range:, rooms: [])
      @id = SecureRandom.alphanumeric
      @date_range = date_range
      @rooms = rooms
    end

    def total_cost
      return (rooms[0].cost * @date_range.nights).to_f.round(2)
    end
  end
end
