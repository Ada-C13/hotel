require 'room'
require 'date'
require_relative 'test_helper'

describe 'Reservation class' do
  describe 'Initializer' do
    it 'is an instance of Reservation' do
      start_date = Date.new(2001,2,3)
      end_date = Date.new(2001,2,5) 
    res = Reservation.new(1,start_date,end_date)
      expect(res).must_be_kind_of Reservation
    end
  end
end