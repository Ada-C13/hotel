require_relative 'test_helper'

describe 'HotelController class' do 
  describe 'HotelController' do
    before do
      start_date = Date.new(1993, 2, 24)
      end_date = Date.new(1993, 2, 26)
      @reservation = Hotel::HotelController.reserve_room(start_date, end_date)
    end

    it 'makes a reservation with start and end dates' do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end
  end
end