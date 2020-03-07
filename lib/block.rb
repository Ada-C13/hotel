require_relative 'reservation'

module Hotel

	class Block < Reservation

		attr_reader :room, :cost, :range, :length_of_stay
		
		def initialize(room, range, cost)
			super(room, range)

			if room.length > 5 || room.length < 2
				raise ArgumentError.new("Block can only accept up to 5 rooms.")
			else
				@room = room
			end

			@length_of_stay = @range.end_date - @range.start_date
			@cost = cost
		end



	end

end