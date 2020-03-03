require_relative 'test_helper'

describe Hotel::DateRange do
  describe "initialize" do
    before do
      @start_date = Date.new(2020, 1, 1)
      @end_date = Date.new(2020, 1, 2)
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "is an instance of DateRange" do
      expect(@date_range).must_be_kind_of Hotel::DateRange
    end

    it "throws an argument error if end_date comes before start_date" do
      expect do
        Hotel::DateRange.new(@end_date, @start_date)
      end.must_raise ArgumentError
    end

    # come back to clean this up using let syntax later
    # it "throws an argument error if inputs are not Date objects" do
    #   let(:test_date_types) { start_date = 42, end_date = 88 }

    #   expect do
    #     Hotel::DateRange.new(@start_date, @end_date)
    #   end.must_raise ArgumentError
    # end

  end
end