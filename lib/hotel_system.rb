require 'date'

module Hotel

	class HotelSystem

		attr_reader :reservations

		def initialize
			@reservations = []
		end

		# Create a reservation from start date and end date.
		def make_reservation(start_date, end_date)
			range = Hotel::DateRange.new(start_date, end_date)
			new_reservation = Hotel::Reservation.new(range)
			@reservations << new_reservation

			return new_reservation
		end

		# Get all reservations including a specific date.
		def get_reservations(date)
			found_reservations = []

			@reservations.each do |reservation|
				if reservation.range.include?(Date.parse(date))
					found_reservations << reservation
				end
			end

			return found_reservations
		end

	end

end