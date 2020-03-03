PRICE = 200

module Hotel

	class Reservation

		attr_reader :room, :cost, :start_date, :end_date, :length_of_stay

		def initialize(start_date, end_date)
			@room = rand(1..20)

			if !Date.parse(start_date) || !Date.parse(end_date)
				raise ArgumentError.new("Invalid date provided for start or end.")
			elsif Date.parse(end_date) < Date.parse(start_date)
				raise ArgumentError.new("End date cannot be earlier than start.")
			else
				@start_date = Date.parse(start_date)
				@end_date = Date.parse(end_date)
			end

			@length_of_stay = @end_date - @start_date
			@cost = (@length_of_stay * PRICE)
		end



	end

end