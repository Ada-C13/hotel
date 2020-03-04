PRICE = 200

module Hotel

	class Reservation

		attr_reader :room, :cost, :range, :length_of_stay

		def initialize(room, range)
			@room = room

			if range.end_date < range.start_date
				raise ArgumentError.new("End date cannot be earlier than start.")
			else
				@range = range
			end

			@length_of_stay = @range.end_date - @range.start_date
			@cost = (@length_of_stay * PRICE)
		end
		
	end

end