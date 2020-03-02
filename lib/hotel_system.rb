module Hotel

	class HotelSystem


		def make_reservation(start_date, end_date)
			@range = Hotel::DateRange.new(start_date, end_date)

			new_reservation = Hotel::Reservation.new(range)

			return new_reservation
		end

	end

end