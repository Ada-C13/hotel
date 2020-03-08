require_relative 'test_helper'

describe 'Reservation class' do 
  before do
    start_date = Date.new(2021, 2, 24)
    end_date = Date.new(2021, 2, 26)
    room = Hotel::Room.new(20)
    @reservation = Hotel::Reservation.new(start_date, end_date, room)
    @block_reservation = Hotel::Reservation.new(start_date, end_date, room, 123)
  end

  describe 'Reservation instantiation' do
    it 'makes a reservation with start and end dates' do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
 
    it 'contains room number, nights staying, and total cost of stay' do
      expect(@reservation.room_num).must_be_kind_of Integer
      expect(@reservation.nights).must_equal 2
      expect(@reservation.total_cost).must_equal 400
    end

    it 'can take a block_id parameter if reservation is part of a block' do
      expect(@block_reservation.block_id).must_equal 123
    end
  end

  describe 'nights method' do 
    it 'subtracts the depart date from the arrive date' do
      expect(@reservation.nights).must_equal 2
    end
  end
end