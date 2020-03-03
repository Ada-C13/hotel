require_relative 'test_helper'


describe 'Date class' do
  let (:date_range) {
    Hotel::DateRange.new(("2020-02-03"), ("2020-02-04"))
  }
  
  it "instantiates a DateRange object" do
    expect(date_range).must_be_instance_of Hotel::DateRange
  end
  
  it "check-in date is instance of Date" do
    expect(date_range.check_in).must_be_instance_of Date
  end
  
  it "check-out date is an instance of Date" do
    expect(date_range.check_out).must_be_instance_of Date
  end
  
  it "raises an argument error for invalid date" do
    expect { Hotel::DateRange.new("1/21/19", "2020/03/03") }.must_raise ArgumentError
  end

end


# describe "Valid CheckIn Date" do
#   it "raises an argument error for check-in dates in the past" do
#     expect { Hotel::DateRange.new(("2019-02-15"), ("2019-02-17")) }.must_raise ArgumentError
#   end
# end


describe 'Validate Date Range' do
  
  it 'returns an argument error if check out is before check in' do
    expect { Hotel::DateRange.new(("2020-02-05"), ("2020-02-04")) }.must_raise ArgumentError
  end
  
end


describe "Number of Nights" do
  
  it "Calculates 1 night" do
    range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-04"))
    expect(range.num_nights).must_equal 1
  end
  
  it "Calculates many nights" do
    range = Hotel::DateRange.new(("2020-02-03"), ("2020-02-06"))
    expect(range.num_nights).must_equal 3
  end
  
end


describe "Date In Range?" do
  let (:range) {
    Hotel::DateRange.new(("2020-02-03"), ("2020-02-07"))
  }
  
  it "returns true if a date is included in a given range" do
    date = Date.parse("2020-02-04")
    expect(range.date_in_range?(date)).must_equal true
  end
  
  it "returns false if a date is not within a given range" do
    date = Date.parse("2020-02-09")
    expect(range.date_in_range?(date)).wont_equal true
  end
  
end