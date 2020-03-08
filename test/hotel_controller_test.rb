require_relative 'test_helper'

describe 'HotelController class' do 
  before do 
    # Makes a new instance of hotel
    @new_hotel = Hotel::HotelController.new

    # Makes 20 rooms in hotel
    20.times do |room_num|
      room = Hotel::Room.new(room_num + 1)
      @new_hotel.add_room(room)
    end
 
    # Makes a reservation for hotel
    @start_date = Date.new(2021, 2, 24)
    @end_date = Date.new(2021, 2, 26)
    @reservation = @new_hotel.reserve_room(@start_date, @end_date)
  end

  describe 'HotelController add_room' do 
    it 'should have 20 rooms' do
      expect(@new_hotel.rooms).must_be_kind_of Array
      expect(@new_hotel.rooms.length).must_equal 20
    end
  end

  describe "HotelController list_all_rooms" do
    it 'lists all rooms in hotel' do
      expect(@new_hotel.list_all_rooms).must_be_same_as @new_hotel.rooms
    end
  end

  describe 'HotelController total_cost' do
    it 'should return the total cost of a reservation' do
      expect(@new_hotel.total_cost(@reservation)).must_equal 400
    end
  end

  describe 'HotelController find_available_rooms' do
    it 'should return an instance of class Room' do 
      available_rooms = @new_hotel.find_available_rooms(@start_date, @end_date)
      expect(available_rooms.first).must_be_instance_of Hotel::Room
    end

    it 'returns all rooms if there all avaliable with date range given' do
      expect(@new_hotel.find_available_rooms(@start_date, @end_date)).must_be_kind_of Array
      expect(@new_hotel.find_available_rooms(Date.new(2021, 5, 6), Date.new(2021, 5, 8))).must_equal @new_hotel.rooms
    end

    it 'should return available rooms for a specific date' do
      expect(@new_hotel.find_available_rooms(@start_date).length).must_equal 19
    end

    it 'should return an array of all available rooms' do
      15.times do 
        @new_hotel.reserve_room(Date.new(2021, 3, 6), Date.new(2021, 3, 8))
      end
      available_rooms = @new_hotel.find_available_rooms(Date.new(2021, 3, 6), Date.new(2021, 3, 8))
      expect(@new_hotel.find_available_rooms(Date.new(2021, 3, 6), Date.new(2021, 3, 8))).must_equal available_rooms
    end

    it 'should return an empty array if no rooms are available' do
      20.times do 
        @new_hotel.reserve_room(Date.new(2021, 3, 6), Date.new(2021, 3, 8))
      end
      expect(@new_hotel.find_available_rooms(Date.new(2021, 3, 6), Date.new(2021, 3, 8))).must_equal []
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

    it 'raises an Error if reservation is trying to be made without available space' do
      expect{@new_hotel.reserve_room(@end_date, @start_date)}.must_raise ArgumentError
    end

    it 'should have instances of reservation' do
      expect(@new_hotel.reservations).must_be_kind_of Array
      expect(@new_hotel.reservations.first).must_be_kind_of Hotel::Reservation
    end
  end

  describe 'HotelController listing reservations by a specific date or date range' do
    it 'selects reservations given a single date' do
      expect(@new_hotel.reservations_by_date(@start_date)).must_equal @new_hotel.reservations
    end

    it 'lists reservations for a set of date ranges' do
      expect(@new_hotel.reservations_by_date(@start_date, @end_date)).must_equal @new_hotel.reservations
    end

    it 'returns an empty array if no reservations are found' do
      expect(@new_hotel.reservations_by_date(Date.new(2021, 3, 7))).must_equal []
    end
  end

  describe 'HotelController listing reservations by a room number' do
    it "gives an array of all reservations specific to room number" do
      expect(@new_hotel.reservations_by_room_and_dates(1).first.room_num).must_equal 1
    end

    it "gives an array of all reservations specific to room num and date or range" do
      expect(@new_hotel.reservations_by_room_and_dates(1, @start_date).first.room_num).must_equal 1
      expect(@new_hotel.reservations_by_room_and_dates(1, @start_date, @end_date).first.room_num).must_equal 1
    end

    it 'returns an empty array if no reservations are found' do
      expect(@new_hotel.reservations_by_date(Date.new(2021, 3, 7))).must_equal []
    end

    it 'raises an ArgumentError if too many dates are given' do
      expect{(@new_hotel.reservations_by_room_and_dates(1, @start_date, @end_date, Date.new(2021, 3, 15)))}.must_raise ArgumentError
    end
  end

  describe 'HotelController make_block' do 
    it 'should make a block with a date range and rate and number of rooms' do
      expect(@new_hotel.make_block(@start_date, @end_date, 150, 3)).must_be_instance_of Hotel::Block
    end

    it 'should add the block to a list of all block reservations' do 
      @new_block = @new_hotel.make_block(@start_date, @end_date, 150, 3)
      expect(@new_hotel.blocks.first).must_be_instance_of Hotel::Block
      expect(@new_hotel.blocks.first.date_range.arrive).must_equal @start_date
      expect(@new_hotel.blocks.first.date_range.depart).must_equal @end_date
      expect(@new_hotel.blocks.first.rate).must_equal 150
      expect(@new_hotel.blocks.first.num_of_rooms).must_equal 3
    end

    it 'should make x number of reservations for block' do
      @new_hotel.make_block(@start_date, @end_date, 150, 3)
      expect(@new_hotel.reservations.length).must_equal 4
      #TODO check that each room number is different
    end

    it 'given a range of dates determine if x amount of rooms can be booked' do
      
    end
  end

  xdescribe 'HotelController raising ArrgumentError for invalid new block' do
    it 'raises an exception if more than 5 rooms are entered for block' do
      expect{@new_hotel.make_block(@start_date, @end_date, 150, 6)}.must_raise ArgumentError
    end

    it 'raises an excetion if less than 2 rooms are enterd for a block' do
      
    end

    it 'raises an exception if x amount of rooms cannot be booked for given date range' do
      17.times do 
        @new_hotel.reserve_room(Date.new(2021, 3, 6), Date.new(2021, 3, 8))
      end
      expect{@new_hotel.make_block(@start_date, @end_date, 150, 5)}.must_raise ArgumentError
    end
  end
end