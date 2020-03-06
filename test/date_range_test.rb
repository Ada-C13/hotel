#date range (1) 2001,2,1 - 2001, 2,10    9 nights
#date range (2) 2001,2,1 - 2001, 2,4     3 nights
#date range (3) 2001,1,31 - 2001,2,4    4 nights
#date range (4) 2001,2,4 - 2001, 2,8    4 nights
#date range (5) 2001,2,8 - 2001, 2,10   2 nights
#date range (6) 2001,2,8 - 2001, 2,12   4 nights
#date range (7) 2001,2,12 - 2001,2,14   4 nights






require_relative "test_helper"

describe "Instanitates a new Date Range" do
  let(:check_in_date) { Date.new(2001, 2, 3) }
  let(:check_out_date) { Date.new(2001, 2, 6) }
  it "Initialize Date Range" do
    new_date = Date_Range.new(check_in_date,check_out_date)
    expect(new_date).must_be_kind_of Date_Range
  end

describe 'Checks overlaps - exactly the same'do
  let(:check_in_date) { Date.new(2001, 2, 3) }
  let(:check_out_date) { Date.new(2001, 2, 6) }
  let(:date_range_1) {Date_Range.new(check_in_date,check_out_date)}

  it "If check in is the same as check" do
  #  Arrange 
    date_range_2 = Date_Range.new(check_in_date,check_out_date)
  #  Act 
    test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
  #  Assert
  expect(test_date_range).must_equal true

  end

  it " If  the date range falls inside a current date range" do
  #  Arrange 
    start_two = Date.new(2001,2,4)
    end_two = Date.new(2001,2,5)
    date_range_2 = Date_Range.new(start_two,end_two)
  #  Act 
    test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
  #  Assert
  expect(test_date_range).must_equal true
  end 

  it " If partial overlap, new date range start date fails inside current date" do
  #  Arrange 
    start_two = Date.new(2001,2,2)
    end_two = Date.new(2001,2,5)
    date_range_2 = Date_Range.new(start_two,end_two)
  #  Act 
    test_date_range = date_range_1.overlaps_in_reservations?(date_range_2)
  #  Assert
  expect(test_date_range).must_equal true
  end

  it "If partial overlap, end date fails inside current date "
  end

  it " If a reservations fails inbetween to other reservations" do
  end

  it "If long stay overlaps with another date range" do
  end

  end 