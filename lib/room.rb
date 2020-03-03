require_relative 'reservation'

module Hotel
  class Room
    attr_reader :id, :reservations, :price, :type

    def initialize(id)
      @id = id.to_s
      @reservations = []
      @price = 200
      @type = "standard"
    end

    # TO-DO: add inspect to display all reservations

  end

end