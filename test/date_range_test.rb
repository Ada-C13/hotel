require_relative "test_helper"

describe "DateRange" do
  describe "#initialize" do
    it "raise ArgumentError if end date is earlier than start date" do
      @date_range = Hotel::DateRange.new(
        start_date = "2020-03-10", 
        end_date = "2020-03-13"
      )
    end
  end
end