require_relative "test_helper"

describe Hotel::DateRange do
	
	describe "Wave 1 Requirements" do

		before do
			s_date = 'dec 23'
			e_date = 'dec 28'

			@range = Hotel::DateRange.new(s_date, e_date)
		end

		it "raises ArgumentError if invalid dates are provided for creating reservation" do
			inval_start = "feb 29, 2001"
			inval_end = "march 2, 2001"
			inval_start_two = "feb 27, 2001"

			expect{Hotel::DateRange.new(inval_start, inval_end)}.must_raise ArgumentError
			expect{Hotel::DateRange.new(inval_start_two, inval_start)}.must_raise ArgumentError
			expect{Hotel::DateRange.new(inval_start, inval_start_two)}.must_raise ArgumentError
		end

		it "creates an instance of time from taking two dates" do
			expect(@range).must_be_instance_of Hotel::DateRange
			expect(@range.start_date).must_be_kind_of Date
			expect(@range.end_date).must_be_kind_of Date
		end

		it "#length_of_stay returns the length of days of stay between two dates" do
			expect(@range.length_of_stay).must_equal 5
		end

	end

end