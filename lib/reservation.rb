module Stayappy
  class Reservation
    attr_reader :room, :check_in, :check_out

    def initialize(room:, check_in:, check_out:)
      @room = room
      if check_in > check_out
        raise ArgumentError.new("Your check_out date must come after your check_in date")
      end
      @check_in = check_in
      @check_out = check_out
    end

    def stay()
      return @check_in..@check_out
    end
  end
end