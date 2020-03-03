require_relative "test_helper"

describe Hotel::Reservation do

	describe "Wave 1 Requirements" do

		before do
			room = 20
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2019, 12, 28)

			@new_reservation = Hotel::Reservation.new(room, start_date, end_date)
		end

		it "makes an instance of a Reservation" do
			expect(@new_reservation).must_be_instance_of Hotel::Reservation
			expect(@new_reservation.room).must_be :>, 0
			expect(@new_reservation.room).must_be :<, 21
			expect(@new_reservation.start_date).must_be_instance_of Date
			expect(@new_reservation.end_date).must_be_instance_of Date
			expect(@new_reservation.length_of_stay).must_equal 5
		end

		it "returns the cost of the reservation" do
			expect(@new_reservation.cost).must_equal 1000
		end

		it "raises ArgumentError if invalid dates are provided for creating reservation" do
			inval_end = Date.new(2001, 02, 25)
			inval_start = Date.new(2001, 02, 26)

			expect{Hotel::Reservation.new(10, inval_start, inval_end)}.must_raise ArgumentError
		end
	end

end