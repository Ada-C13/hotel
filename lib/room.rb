module Hotel 
  class Room

    NUMBERS = (1..20)

    attr_reader :number

    def initialize(number)
      if (number.class != Integer) || !NUMBERS.include?(number)
        raise ArgumentError, "#{number} is an invalid value"
      end 
      @number = number 
    end 
  end 
end
