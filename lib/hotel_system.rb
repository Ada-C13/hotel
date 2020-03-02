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
				range = reservation.range.start_date..reservation.range.end_date

				if (range).include?(date)
					found_reservations << reservation
				end
			end

			return found_reservations
		end

		# Get all reservations for a specific room.
		def get_reservations_by_room(room, range_start, range_end)
			found_reservations = []

			@reservations.each do |reservation|
				if reservation.room == room
					if Date.parse(range_start) >= reservation.range.start_date && Date.parse(range_end) <= reservation.range.end_date
						found_reservations << reservation
					end
				end
			end

			return found_reservations
		end

	end

end