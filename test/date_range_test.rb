require_relative 'test_helper'

describe 'DateRange class' do 
  before do 
    start_date = Date.new(2021, 2, 24)
    end_date = Date.new(2021, 2, 26)
    @dates = Hotel::DateRange.new(start_date, end_date)
  end

  describe 'DateRange instantiation' do
    it 'should be two instances of class Date' do
      expect(@dates.arrive).must_be_kind_of Date
      expect(@dates.depart).must_be_kind_of Date
    end

    it 'takes in a start and end date' do
      expect(@dates).must_be_kind_of Hotel::DateRange
    end
  end

  describe 'overlap? method' do
    it 'should return true if given dates are included in reservaton dates' do
      expect(@dates.overlap?(Date.new(2021, 2, 24), Date.new(2021, 2, 26))).must_equal true
      expect(@dates.overlap?(Date.new(2021, 2, 22), Date.new(2021, 2, 28))).must_equal true
      expect(@dates.overlap?(Date.new(2021, 2, 22), Date.new(2021, 2, 26))).must_equal true
      expect(@dates.overlap?(Date.new(2021, 2, 25), Date.new(2021, 2, 26))).must_equal true
      expect(@dates.overlap?(Date.new(2021, 2, 25), Date.new(2021, 2, 28))).must_equal true
    end

    it 'should return false if given dates are not included in reservation dates' do
      expect(@dates.overlap?(Date.new(2021, 2, 22), Date.new(2021, 2, 23))).must_equal false
      expect(@dates.overlap?(Date.new(2021, 2, 22), Date.new(2021, 2, 24))).must_equal false
      expect(@dates.overlap?(Date.new(2021, 2, 26), Date.new(2021, 2, 28))).must_equal false
      expect(@dates.overlap?(Date.new(2021, 2, 27), Date.new(2021, 2, 28))).must_equal false
    end
  end
end