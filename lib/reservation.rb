require_relative 'date_range'
require_relative 'hotel_system'

PRICE = 200

module Hotel

	class Reservation

		attr_reader :room, :cost, :range

		def initialize(range)
			@room = rand(1..20)
			@cost = (range.length_of_stay * PRICE)
			@range = range
		end

	end

end