require_relative 'test_helper'


describe 'Date class' do
  let (:date_range) {
    Hotel::DateRange.new(("2020-02-03"), ("2020-02-04"))
  }
  
  it "instantiates a DateRange object" do
    expect(date_range).must_be_instance_of Hotel::DateRange
  end
    
  # it "raises an argument error for invalid date" do
  #   expect { Hotel::DateRange.new("1/21/19", "2020/03/03") }.must_raise ArgumentError
  # end
end


describe 'Validate Date Range' do
  
  it 'returns an argument error if check out is before check in' do
    expect { Hotel::DateRange.new(("2020-02-05"), ("2020-02-04")) }.must_raise ArgumentError
  end
  
end


describe "Number of Nights" do
  
  it "Calculates 1 night" do
    date1 = Date.today
    date2 = Date.today + 1
    
    range = Hotel::DateRange.new(date1, date2)
    expect(range.num_nights).must_equal 1
  end
  
  it "Calculates many nights" do
    date1 = Date.today
    date2 = Date.today + 3
    
    range = Hotel::DateRange.new(date1, date2)
    expect(range.num_nights).must_equal 3
  end
  
end


describe "Date In Range?" do
  let (:range) { #existing reservation
    Hotel::DateRange.new((Date.today), (Date.today + 5))
  }
  
  it "returns true if a date is included in a given range" do
    # date in question
    date = Date.today + 2
    expect(range.date_in_range?(date)).must_equal true
  end
  
  it "returns false if a date is not within a given range" do
    date = Date.today + 10
    expect(range.date_in_range?(date)).wont_equal true
  end
  
  it "returns false if the date passed is on the end date" do
    date = Date.today + 5
    expect(range.date_in_range?(date)).must_equal false
  end
  
end


describe "Overlap?" do
  before do 
    @current_range = current_range = Hotel::DateRange.new(("2020-03-04"),("2020-03-07"))
  end
  
  it "returns true for the same range" do
    new_range = Hotel::DateRange.new(("2020-03-04"),("2020-03-07"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns true for same start, earlier finish" do
    new_range = Hotel::DateRange.new(("2020-03-04"),("2020-03-05"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns true for earlier start, earlier finish" do
    new_range = Hotel::DateRange.new(("2020-03-03"),("2020-03-06"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns true for earlier start, same finish" do
    new_range = Hotel::DateRange.new(("2020-03-01"),("2020-03-07"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns true for same start, later finish" do
    new_range = Hotel::DateRange.new(("2020-03-04"),("2020-03-09"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns true for earlier start, later finish" do
    new_range = Hotel::DateRange.new(("2020-03-01"),("2020-03-09"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns true for later start, earlier finish" do
    new_range = Hotel::DateRange.new(("2020-03-05"),("2020-03-06"))
    
    expect(@current_range.overlap?(new_range)).must_equal true
  end
  
  it "returns false for a new start date on the end date(old reservation)" do
    new_range = Hotel::DateRange.new(("2020-03-07"),("2020-03-10"))
    
    expect(@current_range.overlap?(new_range)).must_equal false
  end
  
  it "returns false for an end date on existing start date" do
    new_range = Hotel::DateRange.new(("2020-03-01"),("2020-03-04"))
    
    expect(@current_range.overlap?(new_range)).must_equal false
  end
end