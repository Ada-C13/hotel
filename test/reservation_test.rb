require_relative "test_helper"

describe Hotel::Reservation do

	describe "Wave 1 Requirements" do

		it "makes an instance of a Reservation" do
			start_date = "dec 23"
			end_date = "dec 28"

			range = Hotel::DateRange.new(start_date, end_date)

			new_reservation = Hotel::Reservation.new(range)

			expect(new_reservation).must_be_instance_of Hotel::Reservation
			expect(new_reservation.room).must_be :>, 0
			expect(new_reservation.room).must_be :<, 21
			expect(new_reservation.cost).must_equal 200
			expect(new_reservation.range).must_be_instance_of Hotel::DateRange
		end

	end

end