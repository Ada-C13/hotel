require_relative 'reservation'

module Hotel

	class Block < Reservation

		attr_reader
		
		def initialize(room, range)
			super(room, range)

			# if range.end_date < range.start_date
			# 	raise ArgumentError.new("End date cannot be earlier than start.")
			# else
			# 	@range = range
			# end

			@length_of_stay = @range.end_date - @range.start_date
			@cost = ((@length_of_stay * PRICE) * 0.80).to_i
		end

	end

end