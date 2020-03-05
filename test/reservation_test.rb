require_relative 'test_helper'

describe 'Reservation class' do 
  before do 
    # Makes a new instance of hotel
    @new_hotel = Hotel::HotelController.new

    # Makes 20 rooms in hotel
    20.times do |room_num|
      room = Hotel::Room.new(room_num + 1)
      @new_hotel.add_room(room)
    end

    # Makes reservations for hotel
    @start_date = Date.new(2021, 2, 24)
    @end_date = Date.new(2021, 2, 26)
    @reservation = @new_hotel.reserve_room(@start_date, @end_date)
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
  end

  describe 'nights method' do 
    it 'subtracts the depart date from the arrive date' do
      expect(@reservation.nights).must_equal 2
    end
  end
end