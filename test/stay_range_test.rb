require_relative "test_helper"

describe "StayRange" do
  describe "Initialize" do
    it "Create an instance of StayRange" do
      range = Hotel::StayRange.new("March 3, 2020", "March 5, 2020")
      # Assert
      expect(range).must_be_kind_of Hotel::StayRange
    end

    it "Keeps track of the first day" do
      range = Hotel::StayRange.new("March 3, 2020", "March 5, 2020")
      # Assert
      expect(range).must_respond_to :start_date
      expect(range.start_date).must_equal Date.parse("March 3, 2020")
    end

    it "Keeps track of the last day" do
      range = Hotel::StayRange.new("March 3, 2020", "March 5, 2020")
      # Assert
      expect(range).must_respond_to :end_date
      expect(range.end_date).must_equal Date.parse("March 5, 2020")
    end
  end
end