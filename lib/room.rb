
module Hotel
  class Room
    ROOMS = 20
    attr_reader :id, :nightly_rate, :reservations

    def initialize(id)
      if id <= 0 || id > 20
        raise ArgumentError.new("Not a real room")
      end
      @id = id
      @nightly_rate = 200
      @reservations = []
    end

    def self.all
      all_rooms = Array.new
      ROOMS.times do |room|
        all_rooms << self.new(room + 1)
      end
      return all_rooms
    end
  end
end