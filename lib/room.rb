module Hotel

	class Room

		attr_reader :number, :reservations
		
		def initialize(number)
			@number = number
			@reservations = []
		end

	end

end