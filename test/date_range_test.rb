require_relative 'test_helper'

describe 'DateRange class' do 
  describe 'DateRange instantiation' do
    before do 
      start_date = Date.new(1993, 2, 24)
      end_date = Date.new(1993, 2, 26)
      @dates = Hotel::DateRange.new(start_date, end_date)
    end

    it 'takes in a start and end date' do
      
      expect(@dates).must_be_kind_of Hotel::DateRange
    end
  end
end