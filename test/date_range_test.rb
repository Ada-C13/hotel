require_relative "test_helper"

describe Hotel::DateRange do

	describe "Wave 1 Requirements" do

		it "creates an instance of time from taking two dates" do
			start_date = "dec 23"
			end_date = "dec 28"

			range = Hotel::DateRange.new(start_date, end_date)

			expect(range).must_be_instance_of Hotel::DateRange
		end

	end

end