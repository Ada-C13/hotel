require_relative "test_helper"


describe Hotel::DateRange do
  before do
    @start_date = Date.new(2021, 01, 01)
    @end_date = Date.new(2021, 01, 03)

    @range_inst = Hotel::DateRange.new(start_date: @start_date, end_date: @end_date)
  end

  describe "constructor" do

    it "is an instance of DateRange" do
      expect(@range_inst).must_be_kind_of Hotel::DateRange
    end

    it "start_date is a Date" do
      expect(@range_inst.start_date).must_be_kind_of Date
    end

    it "end_date is a Date" do
      expect(@range_inst.end_date).must_be_kind_of Date
    end

    it "dates is an array" do
      expect(@range_inst.dates).must_be_kind_of Array
    end

    it "can be initialized with two dates" do
      expect(@range_inst.start_date).must_equal @start_date
      expect(@range_inst.end_date).must_equal @end_date
    end

    it "raises an error if the end date is before the start date" do
      expect { Hotel::DateRange.new(
        start_date: Date.new(2021, 01, 01),
        end_date: Date.new(2020, 12, 31)
        ) }.must_raise ArgumentError
    end

    it "raises an error if the end date is the same as the start date" do
      expect { Hotel::DateRange.new(Date.new(2021, 01, 01),
        # Date.new(2021, 01, 01)
        ) }.must_raise ArgumentError
    end

    # TODO add test for start_date or end_date is nil, raise argument error


  end

  describe "overlap?" do

    it "returns true for the same range" do
      start_date = @range_inst.start_date
      end_date = @range_inst.end_date
      test_range = Hotel::DateRange.new(start_date: start_date, end_date: end_date)

      expect(@range_inst.overlap?(test_range)).must_equal true
    end

    xit "returns true for a contained range" do
    end

    xit "returns true for a range that overlaps in front" do
    end

    xit "returns true for a range that overlaps in the back" do
    end

    xit "returns true for a containing range" do
    end

    xit "returns false for a range starting on the end_date date" do
    end

    xit "returns false for a range ending on the start_date date" do
    end

    xit "returns false for a range completely before" do
    end

    xit "returns false for a date completely after" do
    end
  end

  xdescribe "include?" do
    it "returns false if the date is clearly out" do
      date = Date.new(2022,1,1)
      expect(@range_inst.include?(date)).must_equal false
    end

    it "returns true for dates in the range" do
      date = @start_date
      expect(@range_inst.include?(date)).must_equal true
    end

    it "returns false for the end_date date" do
      date = @end_date
      expect(@range_inst.include?(date)).must_equal false
    end
  end

  describe "nights" do
    it "returns the correct number of nights" do
      expect(@range_inst.nights).must_equal 2
    end

    it "returns a number" do
      expect(@range_inst.nights).must_be_kind_of Numeric
    end
  end
end
