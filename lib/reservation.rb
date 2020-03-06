require 'date'


module Stayappy

  class Reservation
    attr_reader :room_num, :res_num
    # Make method to initialize the Reservation class.
    def init(check_in:, check_out:, res_num:, room_num:, total:)
      @check_in = check_in
      @check_out = check_out
      @stay = (check_in..check_out)
      @res_num = res_num
      @room_num = room_num
      @total = total
    end

    # See about deleting this 
    def date_vet
      if check_in nil || check_in < Date.new(2020, 3, 9) 
        raise ArgumentError.new("Invalid check-in date.")
      end
      if check_out nil || check_out > Date.new(2040, 3,)
        raise ArgumentError.new("Invalid check_out date.")
      end 

    end 

    # Method to take a valid date request and assign a room to it.
    def assign_room
      if AVAILABLE_ROOMS >= 1
        room_num = AVAILABLE_ROOMS.pop(0)
        UNAVAILABLE_ROOMS << room_num
      end
      if AVAILABLE_ROOMS < 1
        raise ArgumentError.new("The hotel is full during that reservation window.")
      end
      room_num
    end

    def book_of_bookings
      visit = {stay: @reservation.stay, room_num: @reservation.room_num}
      BOOKINGS << visit
    end

    # Keep this for potential use in make_reservation method. 
    # def booked_already?
    #   if @reservation.stay.includes?(@reservation.room_num)
    #     raise ArgumentError.new("That room is already booked for part/all of those proposed dates.")
    #   end
    # end

    def receipt
      #Calculates the entire cost of stay
      receipt = stay.length - 1
      receipt = receipt * 200.00
    end
  end 
end 