require_relative 'reservation'

module Hotel
  class Room
    attr_reader :room_id,:bookings
    attr_accessor :cost

    def initialize(room_id, cost = 200.00, bookings = nil)
      raise ArgumentError if !room_id.is_a? Integer
      raise ArgumentError if room_id < 1
      @room_id = room_id
      @cost = cost
      @bookings = bookings || []
    end

    def add_booking_to_room(new_reservation)
      @bookings << new_reservation
    end

    def  get_price(reservation)
      price = reservation.date_range.count_nights * cost
      return price
    end

    def is_available(given_range)   
      return true if bookings.empty?

      bookings.each do |item|
        if item.block >= 0   #item.class == Hotel::Block 
          return false if item.date_range.overlapping(given_range) && item.date_range.exactly_matching(given_range)== false #it is not an exact match #method
        elsif item.block < 0   #item.class == Hotel::Reservation
          return false if item.date_range.overlapping(given_range)
        end
      end

      return true
    end

    def change_rate(new_rate)
      raise ArgumentError if !new_rate.is_a?(Numeric) || new_rate.to_f < 0
      @cost = new_rate.to_f
    end
  end
end
