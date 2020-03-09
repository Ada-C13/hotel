module Hotel 
  class Room

    attr_accessor :number, :cost, :reservation_ids

    VALID_NUMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] # hotel has 20 rooms

    def initialize(number:, cost: 200.00, reservation_ids: [])
      if VALID_NUMS.include?(number) == false 
        raise ArgumentError.new("Room ##{number} does not exist")
      end 
      @number = number
      @cost = cost 
      @reservation_ids = reservation_ids
    end

  end 
end  