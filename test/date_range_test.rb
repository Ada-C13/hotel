require_relative 'test_helper'

describe "DateRange class" do 

  describe "initilize" do 
    before do
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,5]
      )
    end 
    it "date_range is an instance of DateRange" do 
      expect(@date_range).must_be_instance_of Hotel::DateRange
    end 
    it "raise ArgumentError if end_date before start_date" do 
      start_date = [2020,3,1]
      end_date = [2020,2,29]
      expect { Hotel::DateRange.new(start_date: start_date, end_date: end_date) }.must_raise ArgumentError
    end 
    it "raise ArgumentError if end_date/start_date not a valid date" do 
      start_date = [2020,12,25]
      end_date = [2020,13,31]
      expect { Hotel::DateRange.new(start_date: start_date, end_date: end_date) }.must_raise ArgumentError
    end 
  end 

  describe "overlap method" do 
  it "return true when 2 date_range overlap" do 
    @date_range_1 = Hotel::DateRange.new(
      start_date:[2020,3,2],
      end_date:[2020,3,5]
    )
    @date_range_2 = Hotel::DateRange.new(
      start_date:[2020,3,3],
      end_date:[2020,3,5]
    )
    expect(@date_range_1.overlap(@date_range_2)).must_equal true
  end 
  it "return false when 2 date_range do not overlap" do 
    @date_range_1 = Hotel::DateRange.new(
      start_date:[2020,3,2],
      end_date:[2020,3,5]
    )
    @date_range_2 = Hotel::DateRange.new(
      start_date:[2020,3,5],
      end_date:[2020,3,6]
    )
    expect(@date_range_1.overlap(@date_range_2)).must_equal false
  end 

  end 





end 