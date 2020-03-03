PRICE = 200

module Hotel

	class Reservation

		attr_reader :room, :cost, :start_date, :end_date, :length_of_stay

		def initialize(room, start_date, end_date)
			@room = room

			if end_date < start_date
				raise ArgumentError.new("End date cannot be earlier than start.")
			else
				@start_date = start_date
				@end_date = end_date
			end

			@length_of_stay = @end_date - @start_date
			@cost = (@length_of_stay * PRICE)
		end
		
	end

end