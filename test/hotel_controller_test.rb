require_relative 'test_helper'

describe 'HotelController class' do 
  describe 'HotelController making reservations' do
    before do
      @start_date = Date.new(1993, 2, 24)
      @end_date = Date.new(1993, 2, 26)
      @reservation = Hotel::HotelController.reserve_room(@start_date, @end_date)
    end

    it 'makes a reservation with start and end dates' do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it 'raises an Error if there are not two seperate dates given' do
      same_date = Date.new(1993, 2, 24)
      expect{Hotel::HotelController.reserve_room(@start_date, same_date)}.must_raise ArgumentError
    end

    it 'raises an Error if the end date is before the start date' do
      expect{Hotel::HotelController.reserve_room(@end_date, @start_date)}.must_raise ArgumentError
    end
  end

  describe 'HotelController listing reservations' do
    before do
      start_date = Date.new(1993, 2, 24)
      end_date = Date.new(1993, 2, 26)
      @reservation = Hotel::HotelController.reserve_room(start_date, end_date)
    end

    it 'lists all rooms in hotel' do

    end

    it 'lists reservations for specific room' do
      Hotel::HotelController.list_reservations(@start_date)
    end

    it 'lists reservations for specific date range or single date given' do
      
    end
  end
end