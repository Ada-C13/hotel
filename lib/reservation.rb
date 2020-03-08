require 'date'

module Stayappy

  class Reservation
    attr_reader :check_in, :check_out, :room_num, :res_num, :total
    # Make method to initialize the Reservation class.
    def initialize(check_in, check_out, res_num, room_num, total = "reservation")
      @check_in = check_in
      @check_out = check_out
      @stay = (check_in..check_out)
      date_vet
      @res_num = res_num
      @room_num = room_num
      @total = total
    end

  def date_vet
    if !check_in.is_a? Date
      raise ArgumentError.new("Must use valid instance of Date class for check_in.")
    end

    if !check_out.is_a? Date
      raise ArgumentError.new("Must use valid instance of Date class for check_in.")
    end

    if check_in < Date.today 
      raise ArgumentError.new("Invalid check-in date. Please choose today's date, or a later date to check-in on.")
    end

    if check_out > Date.new(2030, 3, 10)
      raise ArgumentError.new("Invalid check_out date; the hotel doesn't accept reservations that far in advance.")
    end 

    if check_in > check_out || check_out < check_in
      raise ArgumentError.new("Your check-in date must pre-date your check-out date.")
    end
  end 

    def receipt
      #Calculates the entire cost of stay
      receipt = @stay.size - 1
      receipt = receipt * 200.00
    end
  end 
end 