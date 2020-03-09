module Hotel
  class Room
    ROOMS = 20
    attr_reader :id, :nightly_rate

    def initialize(id)
      # (Guard clause) raise error if requirement not met
      raise StandardError.new("Not a real room") if id <= 0 || id > 20
  
      @id = id
      @nightly_rate = 200
    end

    # Set as empty array if no instance variable was instantiated
    def reservations
      @reservations ||= []
    end

    def self.all
      all_rooms = Array.new
      ROOMS.times { |room| all_rooms << self.new(room + 1) }
      return all_rooms
    end
  end
end