module HotelBooking
  class Room
    attr_reader :number, :cost, :unavailable_dates
    def initialize(number:, cost: 200)
      @number = number
      @cost = cost

      raise ArgumentError.new("That room number does not exist") if !((1..20).include? number)

    end
    
  end
end