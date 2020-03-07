module Hotel 
  class Block 

    attr_reader :date_range, :rooms, :reservations 

    def initialize(date_range, rooms = [], reservations = []) 
      @date_range = date_range
      @rooms = rooms
      @reservations = reservations
    end 

    [1, 2, 3].reduce(0) { |sum, n| sum + n } # => 6

    def total_block_cost 
      return @reservations.reduce(0) { |sum, reservation|
        sum + reservation.total_cost
      }.to_f.round(2)
    end 
  end 
end 