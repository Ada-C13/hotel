require_relative 'test_helper'

describe 'Reservation class' do 
  describe 'Reservation instantiation' do
    before do 
      start_date = Date.new(1993, 2, 24)
      end_date = Date.new(1993, 2, 26)
      @reservation = Hotel::Reservation.new(start_date, end_date)
    end

    it 'makes a reservation with start and end dates' do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
end