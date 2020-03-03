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
end 
