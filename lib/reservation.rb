module Hotel
  class Reservation
    attr_reader :date_range, :room_number

    def initialize(date_range, room_number)
      @date_range = date_range
      # @room_number = room_number
    end

    # def cost
    # end
  end
end