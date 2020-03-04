require_relative 'test_helper'

describe 'Reservation class' do 
  describe 'Reservation instantiation' do
    before do 
      arrive = Date.new(1993, 2, 24)
      depart = Date.new(1993, 2, 26)
      @reservation = Hotel::Reservation.new(arrive, depart)
    end

    it 'makes a reservation with start and end dates' do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it 'contains room number, nights staying, and total cost of stay' do
      expect(@reservation.room_num).must_be_kind_of Integer
      expect(@reservation.nights).must_equal 2
      expect(@reservation.total_cost).must_equal 0
    end
  end
end