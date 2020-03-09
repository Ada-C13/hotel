require_relative "test_helper"

describe Hotel::Reservation do

	describe "#initialize" do
		before do
			room = Hotel::Room.new(20)
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2019, 12, 28)

			@new_reservation = Hotel::Reservation.new(room, Hotel::DateRange.new(start_date, end_date))
		end

		it "creates an instance of Reservation" do
			expect(@new_reservation).must_be_instance_of Hotel::Reservation
		end

		it "contains an instance of Room assigned" do
			expect(@new_reservation.room).must_be_instance_of Hotel::Room
		end

		it "@length_of_stay is 5" do
			expect(@new_reservation.length_of_stay).must_equal 5
		end

		it "@cost will be 1000" do
			expect(@new_reservation.cost).must_equal 1000
		end

		it "contains a Range assigned" do
			expect(@new_reservation.range).must_be_instance_of Hotel::DateRange
		end

		it "raises ArgumentError if invalid dates are provided for creating reservation" do
			inval_start = Date.new(2001, 02, 26)
			inval_end = Date.new(2001, 02, 25)
			
			inval_range = Hotel::DateRange.new(inval_start, inval_end)

			expect{Hotel::Reservation.new(10, inval_range)}.must_raise ArgumentError
		end

	end

end