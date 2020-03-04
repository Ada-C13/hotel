require 'date'
require_relative 'test_helper'

describe 'Reservation class' do
  describe 'Initializer' do
    let(:start_date){Date.new(2001, 2, 3)}
    let(:end_date){Date.new(2001, 2, 6)}
    it 'is an instance of Reservation' do
    res = Reservation.new(Room.new(1),start_date,end_date)
      expect(res).must_be_kind_of Reservation
    end
    describe 'Reservation total method' do
      it 'takes in the date' do 
        res = Reservation.new(Room.new(1),start_date, end_date)
        expect(res.total).must_equal 400
      end
    end
  end
end