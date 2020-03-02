require_relative "test_helper"

describe Hotel::DateRange do

	describe "Wave 1 Requirements" do

		it "creates an instance of time from taking two dates" do
			s_date = 'dec 23'
			e_date = 'dec 28'

			range = Hotel::DateRange.new(s_date, e_date)

			expect(range).must_be_instance_of Hotel::DateRange
			expect(range.start_date).must_be_kind_of Date
			expect(range.end_date).must_be_kind_of Date
		end

	end

end