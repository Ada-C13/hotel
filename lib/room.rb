module HotelBooking
  class Room
    attr_reader :number, :cost, :unavailable_dates, :in_block
    attr_writer :in_block
    def initialize(number:, cost: 200, in_block: false)
      @number = number
      @cost = cost
      @in_block = in_block

      raise ArgumentError.new("That room number does not exist") if !((1..20).include? number)

    end

    def ==(other)
      return @number == other.number
    end
    
  end
end