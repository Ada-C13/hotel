require 'time'

module Hotel
  class Reservation
    attr_accessor :start_date, :end_date, :guest, :num_rooms
    
    COST = 200

    def initialize(start_date:, end_date:, guest:, num_rooms:)
      @start_date = Time.parse(start_date)
      @end_date = Time.parse(end_date)
      @guest = guest
      @num_rooms = num_rooms

      # if @start_date > @end_date
      #   raise ArgumentError.new("Invalid times: #{@start_date} comes after #{@end_date}")
      # end
    end

    def total_cost
      days = ((@end_date - @start_date)/60/60/24)*200
      return days
    end
  
  end
end