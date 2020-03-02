require_relative 'test_helper'

describe 'initialize' do
  before do
    @date = Hotel::DateRange.new([2020, 1, 28], [2020, 1, 30])
  end
  it "can be created" do
    expect(@date).must_be_instance_of Hotel::DateRange
  end
  it "will have the correct amount of readable attributes" do
    expect(@date).must_respond_to :check_in_time
    expect(@date).must_respond_to :check_out_time
    expect(@date).must_respond_to :days
  end
  it "will have check in and check out times that are Date objects" do
    expect(@date.check_in_time).must_be_instance_of Date
    expect(@date.check_out_time).must_be_instance_of Date
  end
  it "will not create instance if check out time is before check in time" do
    expect {
      Hotel::DateRange.new([2020, 1, 28], [2020, 1, 27])
    }.must_raise ArgumentError
  end
  it "will have the correct number of days" do
    expect(@date.days.length).must_equal 3
  end
  it "will create an array of Date objects" do
    expect(@date.days).must_be_instance_of Array
    expect(@date.days).wont_be_empty
    expect(@date.days[0]).must_be_instance_of Date
  end
end

describe "nights method" do
  before do
    @date = Hotel::DateRange.new([2020, 1, 28], [2020, 1, 30])
  end
  it "can be called" do
    expect(@date).must_respond_to :nights
  end
  it "will calculate number of nights" do
    expect(@date.nights).must_equal (@date.days.length - 1)
  end
  it "will not equal the number of days" do
    expect(@date.nights).wont_equal @date.days.length
  end
end
