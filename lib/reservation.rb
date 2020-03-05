require 'date'

require_relative 'date_range'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :id, :dates, :occupancy 

    def initialize(type, dates, occupancy)
      @id = type[0] + dates.to_id 
      @dates = dates
      @occupancy = occupancy
    end

    def total_price 
      # if @occupancy.length > 1 #block
        return @occupancy.sum { |occupancy| occupancy[:room].price * @dates.nights_spent }
      # end
      # return @dates.nights_spent * @occupancy[0][:room].price
    end

  end
end
