require_relative 'test_helper'

describe "DateRange class" do 
  let (:date_range) {

    # Arrange 
    start_date = "2020-3-20"
    end_date = "2020-3-27"

    # Act
    Hotel::DateRange.new(start_date, end_date)
  }
  
  describe "#initialize" do
    it "Creates start_date and end_date" do
      # Assert 
      expect(date_range).must_respond_to :start_date
      expect(date_range).must_respond_to :end_date 
      
      expect(date_range.start_date).must_be_instance_of Date
      expect(date_range.end_date).must_be_instance_of Date
    end 
  end 


  # I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
  describe "#valid_dates?" do 
      
    it "Raises an ArugmentError if start date is after end date" do 
      # Arrange
      invalid_date_range = Hotel::DateRange.new("2020-3-20", "2020-3-15")

      expect(date_range).must_respond_to :valid_dates? 

      expect{invalid_date_range.valid_dates?}.must_raise ArgumentError
    end 

    it "Raises an ArgumentError when the date range is not between current date and end of the year" do 

      # Arrange
      invalid_date_range = Hotel::DateRange.new("2019-12-30", "2020-3-27")

      invalid_date_range_2 = Hotel::DateRange.new("0000-3-20", "2020-3-27")

      # Act & Assert
      expect{invalid_date_range.valid_dates?}.must_raise ArgumentError

      expect{invalid_date_range_2.valid_dates?}.must_raise ArgumentError
    end 
  end 
end 
