module Hotel
  class Block
    attr_reader :arrive, :depart, :rate
    def initialize(arrive, depart, rate)
      @arrive = arrive
      @depart = depart
      @rate = rate
    end
  end
end