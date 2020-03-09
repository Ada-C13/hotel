module Stayappy
  class Room
    attr_reader :room_num, :cost
    
    def initialize(room_num:, cost:)
      @room_num = room_num
      @cost = cost
    end
    
  end
end
