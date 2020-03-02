require_relative 'test_helper'

describe 'initialize' do
  before do
    @date = Hotel::DateRange.new([2020, 1, 28], [2020, 1, 29])
  end
  it "can be created" do
    expect(@date).must_be_instance_of Hotel::DateRange
  end
  it "will have check in and check out times that are Date objects" do
    expect(@date.check_in_time).must_be_instance_of Date
    expect(@date.check_out_time).must_be_instance_of Date
  end
  it "will not create instance if check out time is before check in time" do
    expect {
      date = Hotel::DateRange.new([2020, 1, 28], [2020, 1, 27])
    }.must_raise ArgumentError
  end
end

describe 'create_days method' do
  before do
    @date = Hotel::DateRange.new([2020, 1, 28], [2020, 1, 30])
  end
  it "will assess the correct number of days" do
    expect(@date.days.length).must_equal 3
  end
  it "will create an array of Date objects" do
    expect(@date.days).must_be_instance_of Array
    expect(@date.days[0]).must_be_instance_of Date
  end

end