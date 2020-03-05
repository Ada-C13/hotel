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

  describe 'get_all_dates method' do
    it 'takes in an arrive and depart dates' do
      expect(Hotel::DateRange.get_all_dates(@dates.arrive, @dates.depart)).must_be_kind_of Array
    end

    it 'returns an array with all dates in dates range' do 
      all_dates = (@dates.arrive..@dates.depart).map { |date| date }
      one_date = (@dates.arrive..@dates.arrive).map { |date| date }
      expect(Hotel::DateRange.get_all_dates(@dates.arrive, @dates.depart)).must_equal all_dates
      expect(Hotel::DateRange.get_all_dates(@dates.arrive, @dates.arrive)).must_equal one_date
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