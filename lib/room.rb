module Hotel
  class Room
    ROOMS = 20
    attr_reader :id, :nightly_rate

    def initialize(id)
      raise ArgumentError.new("Not a real room") if id <= 0 || id > 20
  
      @id = id
      @nightly_rate = 200
    end

    def reservations
      @reservations ||= []
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