COST = 200

module Hotel

	class Reservation

		attr_reader :room, :cost, :range

		def initialize(range)
			@room = rand(1..20)
			@cost = COST
			@range = range
		end



	end

end