require_relative 'test_helper'

describe 'HotelController class' do 
  before do 
    # Makes a new instance of hotel
    @new_hotel = Hotel::HotelController.new

    # Makes 20 rooms in hotel
    20.times do |room_num|
      room = Hotel::Room.new(room_num)
      @new_hotel.add_room(room)
    end

    # Makes reservations for hotel
    @start_date = Date.new(1993, 2, 24)
    @end_date = Date.new(1993, 2, 26)
    @reservation = @new_hotel.reserve_room(@start_date, @end_date)
  end

  describe 'HotelController adding and listing rooms' do 
    it 'should have 20 rooms' do
      expect(@new_hotel.rooms).must_be_kind_of Array
      expect(@new_hotel.rooms.length).must_equal 20
    end

    it 'lists all rooms in hotel' do
      expect(@new_hotel.list_of_all_rooms).must_be_same_as @new_hotel.rooms
    end
  end

  describe 'HotelController making reservations' do
    it 'makes a reservation with start and end dates' do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it 'raises an Error if there are not two seperate dates given' do
      expect{@new_hotel.reserve_room(@start_date, @start_date)}.must_raise ArgumentError
    end

    it 'raises an Error if the end date is before the start date' do
      expect{@new_hotel.reserve_room(@end_date, @start_date)}.must_raise ArgumentError
    end
  end

  describe 'HotelController listing reservations' do
    it 'should have instances of reservation' do 
      expect(@new_hotel.reservations).must_be_kind_of Array
      expect(@new_hotel.reservations.first).must_be_kind_of Hotel::Reservation
    end

    it 'selects specific reservations given a single date' do
      date = @new_hotel.reservations.select{ |res| res.arrive == @start_date}
      expect(@new_hotel.list_reservations(given_date: @start_date)).must_equal date
    end

    it 'lists reservations for a specific room' do
      room_1 = @new_hotel.reservations.select{ |res| res.room_num == 1 && res.arrive == @start_date}
      expect(@new_hotel.list_reservations(given_date: @start_date, room: 1)).must_equal room_1

    end

    it 'lists reservations for a set of date ranges' do
      dates = @new_hotel.reservations.select{ |res| res.arrive >= @start_date && res.depart <= @end_date }
      expect(@new_hotel.list_reservations(given_date: @start_date, second_date: @end_date)).must_equal dates
    end
  end
end