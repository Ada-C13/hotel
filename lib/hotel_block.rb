module Hotel
  class HotelBlock
    attr_reader :date_range, :rooms, :discount_rate, :id

    def initialize(date_range, rooms, discount_rate, id)
      @date_range = date_range
      @rooms = rooms
      raise ArgumentError.new("Max of 5 rooms can be reserved in a block") if rooms.length > 5
      @discount_rate = discount_rate
      calculate_discounted_rate()
      @id = id
    end

    def calculate_discounted_rate()
      if @discount_rate > 1
        @discount_rate *= 0.01
      end
      @rooms.each do |room|
        room.cost -= (room.cost * @discount_rate)
      end
    end

    def check_availability
      available_rooms = []
      find_reservations.each do |reservation|
        available_rooms << reservation.room_number if reservation.available == true
      end
      return available_rooms
    end

    def find_reservations
      reservations = []
      @rooms.each do |room|
        reservations << room.reservations.find { |reservation| reservation.hotel_block == @id }
      end
      return reservations
    end

  end
end