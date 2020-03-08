require_relative 'test_helper'

describe "DateRange class" do 
  let (:date_range) {

    # Arrange 
    start_date = Date.new(2020, 3, 20)
    end_date = Date.new(2020, 3, 27)

    # Act
    Hotel::DateRange.new(start_date, end_date)
  }
  
  describe "#initialize" do
    it "creates start_date and end_date" do
      # Assert 
      expect(date_range).must_respond_to :start_date
      expect(date_range).must_respond_to :end_date 
      
      expect(date_range.start_date).must_be_instance_of Date
      expect(date_range.end_date).must_be_instance_of Date

      expect(date_range.start_date).must_equal Date.new(2020, 3, 20)
      expect(date_range.end_date).must_equal Date.new(2020, 3, 27)
    end 


    # I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
    it "raises an ArugmentError if start date is after end date" do 

      expect{Hotel::DateRange.new(Date.new(2020, 3, 20), Date.new(2020, 3, 15))}.must_raise ArgumentError
    end 

    it "raise an ArgumentError to create a 0-length range" do
      expect{
        Hotel::DateRange.new(Date.new(2020, 3, 20), Date.new(2020, 3, 20))
      }.must_raise ArgumentError
    end 

    it "raises an ArgumentError if start_date or end_date is not a Date class" do 
      expect{
        Hotel::DateRange.new("string", Date.new(2020, 3, 20))
      }.must_raise ArgumentError

      expect{
        Hotel::DateRange.new(Date.new(2020, 3, 20), 10)
      }.must_raise ArgumentError
    end 

    it "raises an ArgumentError when the date range is not between current date and end of the year" do 
     
      # Act & Assert
      expect{
        Hotel::DateRange.new(Date.new(2019, 12, 30), Date.new(2020, 3, 27))
      }.must_raise ArgumentError

      expect{
        Hotel::DateRange.new(Date.new(0000, 3, 20), Date.new(2020, 3, 27))
      }.must_raise ArgumentError
    end 
  end

  
  describe "#nights" do 
    it "calculates the correct number of nights" do       
      expect(date_range).must_respond_to :nights
      
      expect(date_range.nights).must_be_kind_of Integer

      expect(date_range.nights).must_equal 7
    end 
  end 


  describe "#include?" do 
    it "returns false if the date is clearly out" do
      date = Date.new(2020, 6, 8)

      expect(date_range.include?(date)).must_equal false
    end 

    it "returns true for dates in the range" do
      date_1 = Date.new(2020, 03, 20)
      date_2 = Date.new(2020, 03, 25)
      date_3 = Date.new(2020, 03, 26)

      expect(date_range.include?(date_1)).must_equal true
      expect(date_range.include?(date_2)).must_equal true
      expect(date_range.include?(date_3)).must_equal true
    end
      
    it "returns false for the end_date" do
      date = Date.new(2020, 03, 20)

      expect(date_range.include?(date)).must_equal true
    end
  end 

  describe "#overlap?" do
    before do
      start_date = Date.new(2020, 6, 8)
      end_date = start_date + 7

      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns true for the same range" do
      start_date = Date.new(2020, 6, 8)
      end_date = start_date + 7
      
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns true for a contained range" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 10), Date.new(2020, 6, 12))

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in front" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 5), Date.new(2020, 6, 9))

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns true for a range that overlaps in the back" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 14), Date.new(2020, 6, 20))

      expect(range.overlap?(test_range)).must_equal true
    end

    it "returns true for a containing range" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 5), Date.new(2020, 6, 16))

      expect(range.overlap?(test_range)).must_equal true
    end

    # Question
    it "returns false for a range starting on the end_date" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 15), Date.new(2020, 6, 18))

      expect(range.overlap?(test_range)).must_equal false
    end

    # Question
    it "returns false for a range ending on the start_date" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 2), Date.new(2020, 6, 8))

      expect(range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range completely before" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 6, 2), Date.new(2020, 6, 7))

      expect(range.overlap?(test_range)).must_equal false
    end

    it "returns false for a date completely after" do
      range = Hotel::DateRange.new(Date.new(2020, 6, 8), Date.new(2020, 6, 15))
      test_range = Hotel::DateRange.new(Date.new(2020, 7, 5), Date.new(2020, 7, 8))

      expect(range.overlap?(test_range)).must_equal false
    end
  end
end 