module Hotel
  class Room
    attr_reader :id, :reservations

    def initialize(id)
      @id = id
      @reservations = []
    end

    def available?(reservation)
      if reservations.length == 0
        return true
      end
      if reservations.none? {|r| !(r.overlap?(reservation))}
        return false
      else
        return true
      end
    end
    
    def add(reservation)
      if self.available?(reservation)
        @reservations << reservation
      else
        raise ArgumentError.new("That room isn't available.")
      end
    end

  end
end
