require_relative 'room'
require_relative 'reservation'

module Hotel
  class HotelBlock < Reservation
    attr_reader :rooms, :date_range, :cost

    def initialize(discounted_rate:, **args)
      super(**args)
      @cost = date_range.days * discounted_rate * @rooms.length
    end
  end
end