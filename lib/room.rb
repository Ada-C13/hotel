module Hotel 
  class Room
    attr_reader :number, :vacancy

    def initialize(number)
      if (number.class != Integer) || (number <= 0) || (number >= 21)
        # con
        raise ArgumentError, "#{number} is an invalid value"
      end 
      @number = number 
      @vacancy = true
    end 

    def change_vacancy
      @vacancy = false if @vacancy == true
    end 
  end 
end