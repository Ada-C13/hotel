PRICE = 200

module Hotel

	class Reservation

		attr_reader :room, :cost, :range, :length_of_stay

		def initialize(room, range, discount = 1)
			@room = room

			if range.end_date < range.start_date
				raise ArgumentError.new("End date cannot be earlier than start.")
			else
				@range = range
			end

			@length_of_stay = (@range.end_date - @range.start_date).to_i
			@cost = (@length_of_stay * PRICE * discount).to_i
		end
		
	end

end