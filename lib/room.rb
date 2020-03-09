module Hotel
  class Room
    attr_reader :id, :price, :type

    def initialize(id)
      @id = id.to_s
      @price = 200
      @type = "standard"
    end
  end

end