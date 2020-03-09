require_relative 'test_helper'

describe 'Reservation class' do 
  before do
    start_date = Date.new(2021, 2, 24)
    end_date = Date.new(2021, 2, 26)
    @room = Hotel::Room.new(20)
    @reservation = Hotel::Reservation.new(start_date, end_date, @room)
    @new_block = Hotel::Block.new(start_date, end_date, 150, 3)
    @block_reservation = Hotel::Reservation.new(start_date, end_date, @room, @new_block)
  end

  describe 'Reservation instantiation' do
    it 'makes a new reservation' do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
 
    it 'contains room number, nights staying, and total cost of stay' do
      expect(@reservation.room_num).must_be_kind_of Integer
      expect(@reservation.nights).must_equal 2
      expect(@reservation.total_cost).must_equal 400
    end

    it 'can take a block parameter if reservation is part of a block' do
      #TODO change this to equal a range of 1111-9999
      expect(@block_reservation.block.block_id).must_equal 1234
    end
  end

  describe 'total_cost' do
    it 'calculates cost of a reservation not in a block' do
      expect(@reservation.get_total_cost(@room, nil)).must_equal 400
    end

    it 'calculates cost of a reservation in a block' do
      expect(@block_reservation.get_total_cost(@room, @new_block)).must_equal 300
    end
  end

  describe 'nights method' do 
    it 'subtracts the depart date from the arrive date' do
      expect(@reservation.nights).must_equal 2
    end
  end
end