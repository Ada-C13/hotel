require_relative "test_helper"

describe Hotel::Block do

	describe "#initialize" do
		before do
			rooms = [Hotel::Room.new(20), Hotel::Room.new(19), Hotel::Room.new(18)]
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2019, 12, 28)

			@new_reservation = Hotel::Block.new(rooms, Hotel::DateRange.new(start_date, end_date), 800)
		end

		it "creates an instance of Block" do
			expect(@new_reservation).must_be_instance_of Hotel::Block
		end

		it "can only create a block with up to 5 rooms" do
			rooms = [Hotel::Room.new(20), Hotel::Room.new(19), Hotel::Room.new(18), Hotel::Room.new(17), Hotel::Room.new(16), Hotel::Room.new(15)]
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2019, 12, 28)

			expect{Hotel::Block.new(rooms, Hotel::DateRange.new(start_date, end_date), 800)}.must_raise ArgumentError
		end

		it "Block @room is an Array" do
			expect(@new_reservation.room).must_be_instance_of Array
		end

		it "Block @range is an instance of DataRange" do
			expect(@new_reservation.range).must_be_instance_of Hotel::DateRange
		end

		it "raises ArgumentError if invalid dates are provided for creating reservation" do
			inval_start = Date.new(2001, 02, 26)
			inval_end = Date.new(2001, 02, 25)
			
			inval_range = Hotel::DateRange.new(inval_start, inval_end)

			expect{Hotel::Block.new([Hotel::Room.new(19), Hotel::Room.new(18)], inval_range)}.must_raise ArgumentError
		end

		it "Block @length_of_stay is accurately calculated" do
			expect(@new_reservation.length_of_stay).must_equal 5
		end

		it "Block @cost is accurately calculated" do
			expect(@new_reservation.cost).must_be_instance_of Integer
			expect(@new_reservation.cost).must_equal 800
		end

	end

end