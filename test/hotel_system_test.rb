require_relative "test_helper"

describe Hotel::HotelSystem do

	describe "Wave 1 Requirements" do

		it "makes an instance of a Reservation" do
			start_date = "dec 23"
			end_date = "dec 28"

			range = Hotel::DateRange.new(start_date, end_date)

			new_reservation = Hotel::Reservation.new(range)

			expect(new_reservation).must_be_instance_of Hotel::Reservation
		end

	end

end