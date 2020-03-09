module Hotel
  class Room
    attr_reader :id, :cost
    def initialize(id, cost)
      @id = id unless !id.respond_to?(:/)
      @cost = cost.to_f unless !cost.respond_to?(:/)

      if @id == nil || @cost == nil
        raise ArgumentError, "Both the id and cost need to be integers."
      end
    end
  end
end