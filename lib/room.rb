
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

  end
end