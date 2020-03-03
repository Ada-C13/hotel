require 'date'

require_relative 'reservation'

module Hotel
	class HotelSystem
		attr_reader :rooms, :reservations

		def initialize
			@rooms = []
			@reservations = []		
			
			20.times do |i|
				@rooms << (i + 1)
			end
		end

		# Create a reservation from start date and end date.
		def make_reservation(start_date, end_date)
			room = room_finder(start_date, end_date)
			new_reservation = Hotel::Reservation.new(room, start_date, end_date)
			@reservations << new_reservation

			return new_reservation
		end

		# Finds an available room within constraints of date range.
		def room_finder(range_start, range_end)
			possible_rooms = @rooms

			@reservations.each do |reservation|
				if range_start >= reservation.start_date || range_end < reservation.end_date
					possible_rooms.delete(reservation.room)
				end
			end
			
			raise ArgumentError.new("No rooms left for this time range") if possible_rooms.length == 0

			return possible_rooms.sample
		end

		# Get all reservations by a specific date.
		def get_reservations_by_date(date)
			found_reservations = []

			@reservations.each do |reservation|
				range = reservation.start_date..reservation.end_date

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
					if range_start >= reservation.start_date && range_end <= reservation.end_date
						found_reservations << reservation
					end
				end
			end

			return found_reservations
		end

		# Get all rooms available for a date.
		def get_rooms_by_date(date)
			avail_rooms = @rooms

			@reservations.each do |reservation|
				range = reservation.start_date...reservation.end_date

				if (range).include?(date)
					avail_rooms.delete(reservation.room)
				end
			end

			return avail_rooms
		end
	end
end