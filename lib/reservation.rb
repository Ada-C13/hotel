require 'time'

module Hotel
  class Reservation
    attr_accessor :start_date, :end_date, :num_rooms
    
    COST = 200

    def initialize(start_date:, end_date:, num_rooms:)
      @start_date = Time.parse(start_date)
      @end_date = Time.parse(end_date)
      @num_rooms = 1

      if @start_date > @end_date || @start_date == @end_date
        raise ArgumentError.new("Invalid times: #{@start_date} comes after #{@end_date}")
      end
    end

    def total_cost
      days = ((@end_date - @start_date)/3600/24)*COST
      return days
    end

    # def self.available?
    #   Hotel::Reservation.each do |booking|
    #     return false if booking.start_date == reservation.start_date && booking.end_date == reservation.end_date
    #   end
    #end
  end
end