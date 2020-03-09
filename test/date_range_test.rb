require_relative "test_helper"


describe "DateRange Class" do 
  
  describe "initialize" do 
    # Assumption: start and end date will always be Ruby Date objects 
    it "creates an instance of a DateRange object" do
      start_date = Date.new(2020, 8, 4)
      end_date = start_date + 5
      @test_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(@test_range).must_be_kind_of Hotel::DateRange
    end
   
    it "can be initialized with a Date object for start_date" do 
      start_date = Date.new(2020, 8, 4)
      end_date = start_date + 5
      @test_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(@test_range.start_date).must_equal start_date
    end

    it "can be initialized with a Date object for end_date" do 
      start_date = Date.new(2020, 8, 4)
      end_date = start_date + 5
      @test_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(@test_range.end_date).must_equal end_date
    end

    it "raises an error if end_date is before start_date" do 
      expect{Hotel::DateRange.new(start_date: Date.new(2020, 8, 9), end_date: Date.new(2020, 8, 4))}.must_raise ArgumentError
    end

    it "raises an error if start_date and end_date are same day" do 
      expect{Hotel::DateRange.new(start_date: Date.new(2020, 8, 4), end_date: Date.new(2020, 8, 4))}.must_raise ArgumentError
    end 
  end

  describe "overlap?" do
    it "returns true if two ranges are the same" do
      start_date = Date.new(2020, 8, 4)
      end_date = Date.new(2020, 8, 9)
      range_1 = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      range_2 = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(range_1.overlap?(range_2)).must_equal true

    end 

    it "returns true if range is completely within other range" do
      range_1_start_date = Date.new(2020, 8, 5)
      range_1_end_date = Date.new(2020, 8, 7)
      range_2_start_date = Date.new(2020, 8, 4)
      range_2_end_date = Date.new(2020, 8, 9)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal true

    end 

    it  "returns true if range's start_date is on the same start_date" do 
      range_1_start_date = Date.new(2020, 8, 4)
      range_1_end_date = Date.new(2020, 8, 14)
      range_2_start_date = Date.new(2020, 8, 4)
      range_2_end_date = Date.new(2020, 8, 10)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal true
    end 

    it  "returns true if range's start_date is within other's range" do 
      range_1_start_date = Date.new(2020, 8, 9)
      range_1_end_date = Date.new(2020, 8, 14)
      range_2_start_date = Date.new(2020, 8, 4)
      range_2_end_date = Date.new(2020, 8, 10)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal true
    end 

    it  "returns true if range's end_date is within other's range" do 
      range_1_start_date = Date.new(2020, 8, 1)
      range_1_end_date = Date.new(2020, 8, 10)
      range_2_start_date = Date.new(2020, 8, 4)
      range_2_end_date = Date.new(2020, 8, 14)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal true
    end 


    it "returns false for a range completely before" do
      range_1_start_date = Date.new(2020, 8, 1)
      range_1_end_date = Date.new(2020, 8, 3)
      range_2_start_date = Date.new(2020, 8, 4)
      range_2_end_date = Date.new(2020, 8, 10)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal false

    end

    it "returns false for a date completely after" do
      range_1_start_date = Date.new(2020, 8, 4)
      range_1_end_date = Date.new(2020, 8, 10)
      range_2_start_date = Date.new(2020, 8, 1)
      range_2_end_date = Date.new(2020, 8, 3)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal false
    end

    it "returns false for a range with a start_date starting on the other range's end_date" do
      range_1_start_date = Date.new(2020, 8, 4)
      range_1_end_date = Date.new(2020, 8, 10)
      range_2_start_date = Date.new(2020, 8, 1)
      range_2_end_date = Date.new(2020, 8, 4)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal false

    end

    it "returns false for a range with end_date on the other range's start_date" do
      range_1_start_date = Date.new(2020, 8, 4)
      range_1_end_date = Date.new(2020, 8, 10)
      range_2_start_date = Date.new(2020, 8, 10)
      range_2_end_date = Date.new(2020, 8, 13)
      range_1 = Hotel::DateRange.new(start_date: range_1_start_date, end_date: range_1_end_date)
      range_2 = Hotel::DateRange.new(start_date: range_2_start_date, end_date: range_2_end_date)
      expect(range_1.overlap?(range_2)).must_equal false
    end
  end 

  describe "include?" do
    it "returns false if the date is completely out of the range" do
      test_date = Date.new(2020, 8, 4)
      start_date = Date.new(2020, 8, 5)
      end_date = Date.new(2020, 8, 7)
      range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(range.include?(test_date)).must_equal false
    end

    it "returns true if the date is in the range" do
      test_date = Date.new(2020, 8, 6)
      start_date = Date.new(2020, 8, 5)
      end_date = Date.new(2020, 8, 7)
      range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(range.include?(test_date)).must_equal true
    end

    it "ignores end_dates as being included" do 
      test_date = Date.new(2020, 8, 7)
      start_date = Date.new(2020, 8, 5)
      end_date = Date.new(2020, 8, 7)
      range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(range.include?(test_date)).must_equal false
    end
  end 

  describe "nights" do
    # Note: initialize already checks start_date and end_date are valid 
    it "calculates the correct number of nights" do
      start_date = Date.new(2020, 8, 4)
      end_date = Date.new(2020, 8, 10)
      range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)
      expect(range.nights).must_equal 6
    end
  end 

end 