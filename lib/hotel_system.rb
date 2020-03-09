require 'date'

require_relative 'reservation'
require_relative 'room'
require_relative 'date_range'

module Hotel
	class HotelSystem

		attr_reader :rooms, :reservations

		def initialize
			@rooms = []
			@reservations = []		
			
			20.times do |i|
				@rooms << Hotel::Room.new(i + 1)
			end
		end

		# Create a reservation from start date and end date.
		def make_reservation(range)
			room = room_finder(range).first
			new_reservation = Hotel::Reservation.new(room, range)
			@reservations << new_reservation
			room.reservations << new_reservation

			return new_reservation
		end

		# Finds an available room within constraints of date range.
		def room_finder(searching_range)
			possible_rooms = @rooms
	
			@reservations.each do |reservation|
				if reservation.range.include_range?(:booking, searching_range) == false
					possible_rooms.delete(reservation.room)
				end
			end
			
			raise ArgumentError.new("No rooms left for this time range") if possible_rooms.length == 0

			return possible_rooms
		end

		# Get all reservations by a specific date.
		def get_reservations_by_date(date)
			found_reservations = []

			@reservations.each do |reservation|
				if reservation.range.include_single_date?(date)
					found_reservations << reservation
				end
			end

			return found_reservations
		end

		# Get all reservations for a specific room in a date range.
		def get_reservations_by_room(room, searching_range)
			found_reservations = []

			room.reservations.each do |reservation|
				if reservation.range.include_range?(:searching, searching_range) == false
					found_reservations << reservation
				end
			end

			return found_reservations
		end

		# Get all rooms available for a date.
		def get_rooms_by_date(date)
			unavail_rooms = get_reservations_by_date(date).map { |reservation| reservation.room }
			return @rooms - unavail_rooms
		end

		# Create a block.
		def make_block(rooms, range, discount)
			possible_rooms = room_finder(range) # Returns available rooms in the given range.
			
			rooms.each do |room|
				if possible_rooms.include?(room)
					new_reservation = Hotel::Reservation.new(room, range, discount)
					@reservations << new_reservation
					room.reservations << new_reservation
				else
					raise ArgumentError.new("Room #{ room.number } already booked for this range.")
				end
			end

			return Hotel::Block.new(rooms, range, discount)
		end

		# Checks the availability of a block of rooms for a given range.
		def check_block_availability(rooms, range)
			possible_rooms = room_finder(range) # Returns available rooms in the given range.
			avail = []

			rooms.each do |room|
				if possible_rooms.include?(room)
					avail << room
				end
			end

			return avail
		end
	end
end