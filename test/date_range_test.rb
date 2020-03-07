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

      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,3],
        end_date:[2020,3,6]
      )
      @date_range_1 = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,4]
      )
      @date_range_2 = Hotel::DateRange.new(
        start_date:[2020,3,5],
        end_date:[2020,3,8]
      )
      @date_range_3 = Hotel::DateRange.new(
        start_date:[2020,3,4],
        end_date:[2020,3,5]
      )
      @date_range_4 = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,9]
      )
      expect(@date_range_1.overlap(@date_range)).must_equal true
      expect(@date_range_2.overlap(@date_range)).must_equal true
      expect(@date_range_3.overlap(@date_range)).must_equal true
      expect(@date_range_4.overlap(@date_range)).must_equal true
    end 
    it "return false when 2 date_range do not overlap" do 
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,3],
        end_date:[2020,3,6]
      )
      @date_range_1 = Hotel::DateRange.new(
        start_date:[2020,3,1],
        end_date:[2020,3,2]
      )
      @date_range_2 = Hotel::DateRange.new(
        start_date:[2020,3,7],
        end_date:[2020,3,8]
      )
      @date_range_3 = Hotel::DateRange.new(
        start_date:[2020,3,6],
        end_date:[2020,3,9]
      )
      @date_range_4 = Hotel::DateRange.new(
        start_date:[2020,3,1],
        end_date:[2020,3,3]
      )
      expect(@date_range_1.overlap(@date_range)).must_equal false
      expect(@date_range_2.overlap(@date_range)).must_equal false
      expect(@date_range_3.overlap(@date_range)).must_equal false
      expect(@date_range_4.overlap(@date_range)).must_equal false
    end 
  end 

  describe "duration method" do 
    it "will return 3 " do 
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,5]
      )
      expect(@date_range.duration).must_equal 3
    end 
  end 

  describe "include_date method" do 
    it "will return true if date within start/end" do 
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,5]
      )
      date = [2020,3,3]
      expect(@date_range.include_date(date)).must_equal true
    end 
    it "will return false if date not within start/end" do 
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,5]
      )
      date = [2020,4,3]
      expect(@date_range.include_date(date)).must_equal false
    end

    it "will return false if date same as end_date" do 
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,5]
      )
      date = [2020,3,5]
      expect(@date_range.include_date(date)).must_equal false
    end


    it "will return true if date same as start_date" do 
      @date_range = Hotel::DateRange.new(
        start_date:[2020,3,2],
        end_date:[2020,3,5]
      )
      date = [2020,3,2]
      expect(@date_range.include_date(date)).must_equal true
    end
    
  end 
end 