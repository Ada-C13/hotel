require_relative "test_helper"
require 'date'

# The start day cannnot be in the past
describe Hotel::DateRange do


  describe "Initilize" do
    it "Can be initialized with two dates" do
      
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3

      @range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.start_date).must_equal start_date
      expect(@range.end_date).must_equal end_date
    end

    it "is an an error for negative-lenght ranges" do
      start_date = Date.new(2017, 01, 01)
      end_date = Date.new(2015, 01, 01)

      expect{
        Hotel::DateRange.new(start_date, end_date)
      }.must_raise ArgumentError

    end

    it "is an error to create a 0-length range" do
      start_date = Date.new(2017, 01, 01)
      end_date = Date.new(2017, 01, 01)

      expect{
        Hotel::DateRange.new(start_date, end_date)
      }.must_raise ArgumentError
      
    end

    it "raises an error for incorrect dates format" do
        start_date = ""
        end_date = ""

        expect { 
          Hotel::DateRange.new(start_date, end_date) 
        }.must_raise ArgumentError

    end
  end

  describe "overlap?" do
    before do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      @range = Hotel::DateRange.new(start_date, end_date)
    end

    it "returns true for the same range" do
      start_date = @range.start_date
      end_date = @range.end_date
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end


    it "returns true for a range that overlaps in front." do
      start_date = Date.new(2017, 01, 02)
      end_date = start_date + 4
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end
    

    it "returns true for a range that overlaps in the back." do
      start_date = Date.new(2016, 12, 30)
      end_date = start_date + 3
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end

    it "returns false for a range ending on the start_date date." do
      start_date = Date.new(2016, 12, 30)
      end_date = Date.new(2017, 01, 01)
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end

    it "returns false for a range starting on the end_date date." do
      start_date = Date.new(2017, 01, 04)
      end_date = start_date + 7
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal false
    end
    
    it "returns true for a contained range." do
      start_date = Date.new(2017, 01, 02)
      end_date = start_date + 1
      test_range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.overlap?(test_range)).must_equal true
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      start_date = Date.new(2017, 01, 01)
      end_date = Date.new(2017, 01, 02)

      @range = Hotel::DateRange.new(start_date, end_date)

      expect(@range.nights).must_be_kind_of Integer
      expect(@range.nights).must_equal 1

    end
  end

end