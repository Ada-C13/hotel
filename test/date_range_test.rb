require_relative "test_helper"

describe Hotel::DateRange do

	describe "#initialize" do

		before do
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2019, 12, 28)

			@new_range = Hotel::DateRange.new(start_date, end_date)
		end

		it "creates an instance of DateRange" do
			expect(@new_range).must_be_instance_of Hotel::DateRange
		end

	end

	describe "#include_range?" do
		
		before do
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2020, 1, 28)

			@new_range = Hotel::DateRange.new(start_date, end_date)
		end

		describe "when booking" do

			it "returns true if searching is found in @new_range" do
				searching_start = Date.new(2020, 1, 1)
				searching_end = Date.new(2020, 1, 5)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:booking, searching)).must_equal true
			end

			it "returns true if searching is found in @new_range" do
				searching_start = Date.new(2019, 12, 23)
				searching_end = Date.new(2020, 1, 5)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:booking, searching)).must_equal true
			end

			it "returns false if searching is not found in @new_range" do
				searching_start = Date.new(2020, 1, 15)
				searching_end = Date.new(2020, 2, 5)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:booking, searching)).must_equal false
			end

			it "returns false if searching is not found in @new_range" do
				searching_start = Date.new(2020, 1, 15)
				searching_end = Date.new(2020, 1, 28)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:booking, searching)).must_equal false
			end

			it "returns false if searching is not found in @new_range" do
				searching_start = Date.new(2020, 12, 22)
				searching_end = Date.new(2020, 1, 28)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:booking, searching)).must_equal false
			end
		end

		describe "when searching" do
			it "returns true if searching is found in @new_range" do
				searching_start = Date.new(2020, 1, 1)
				searching_end = Date.new(2020, 1, 5)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:searching, searching)).must_equal true
			end

			it "returns true if searching is found in @new_range" do
				searching_start = Date.new(2019, 12, 23)
				searching_end = Date.new(2020, 1, 5)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:searching, searching)).must_equal true
			end

			it "a: returns false if searching is not found in @new_range" do
				searching_start = Date.new(2020, 1, 15)
				searching_end = Date.new(2020, 2, 5)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:searching, searching)).must_equal false
			end

			it "b: returns true if searching is not found in @new_range" do
				searching_start = Date.new(2020, 1, 15)
				searching_end = Date.new(2020, 1, 28)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:searching, searching)).must_equal true
			end

			it "c: returns false if searching is not found in @new_range" do
				searching_start = Date.new(2019, 12, 22)
				searching_end = Date.new(2020, 1, 28)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:searching, searching)).must_equal false
			end

			it "d: returns false if searching is not found in @new_range" do
				searching_start = Date.new(2019, 12, 22)
				searching_end = Date.new(2020, 1, 29)
				searching = Hotel::DateRange.new(searching_start, searching_end)

				expect(@new_range.include_range?(:searching, searching)).must_equal false
			end
		end
	end

	describe "#include_single_date?" do

		before do
			start_date = Date.new(2019, 12, 23)
			end_date = Date.new(2020, 1, 28)

			@new_range = Hotel::DateRange.new(start_date, end_date)
		end

		it "returns true if searching is found in @new_range" do
			searching = Date.new(2020, 1, 1)

			expect(@new_range.include_single_date?(searching)).must_equal true
		end

		it "returns true if searching is found in @new_range" do
			searching = Date.new(2019, 12, 23)

			expect(@new_range.include_single_date?(searching)).must_equal true
		end

		it "returns false if searching is not found in @new_range" do
			searching = Date.new(2020, 1, 29)

			expect(@new_range.include_single_date?(searching)).must_equal false
		end

		it "returns false if searching is not found in @new_range" do
			searching = Date.new(2020, 1, 28)

			expect(@new_range.include_single_date?(searching)).must_equal false
		end
	end

end