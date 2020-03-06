require_relative 'test_helper'

describe "Front Desk" do 
  let(:front_desk) { HotelBooking::FrontDesk.new }

  describe "Initialize" do
    it "creates a new instance of FrontDesk" do
      expect(front_desk).must_be_instance_of HotelBooking::FrontDesk
    end

    it "keeps track of hotel rooms" do
      expect(front_desk).must_respond_to :rooms
      expect(front_desk.rooms).must_be_kind_of Array
    end

    it "keeps track of hotel reservations" do
      expect(front_desk).must_respond_to :reservations
      expect(front_desk.reservations).must_be_kind_of Array
    end
  end

  describe "create_rooms" do
    # there are 20 rooms in the rooms array
    it "makes a collection of the 20 roonms" do
      rooms = front_desk.create_rooms
      expect(rooms.length).must_equal 20
      rooms.each do |room|
        expect(room).must_be_instance_of HotelBooking::Room
      end
    end
  end

  describe "make reservation" do
    let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }
    
    it 'can pick an available room' do

    end

    it 'returns nil if no room is available' do
    end

    it 'can create a reservation for found room' do
      expect(front_desk.make_reservation(date_range)).must_be_instance_of HotelBooking::Reservation
    end

    it 'stores a reservation in the reservation list' do
      before_res = front_desk.reservations.length
      front_desk.make_reservation(date_range)
      expect(front_desk.reservations.length).must_equal before_res + 1
    end

    it 'returns the reservation information' do
      res = front_desk.make_reservation(date_range)
      expected_range = HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3))
      expect(res.date_range).must_equal expected_range
    end

  end

  describe "list room reservations" do
    let(:period) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 15)) }
    let(:room) {HotelBooking::Room.new(number: 2)}

    it "takes a date range and a room and returns the list of reservation that rooms has in that time period" do
      reservation_list = front_desk.room_reservations(room, period)

      expect(reservation_list).must_be_kind_of Array
      reservation_list.each do |res|
        expect(res).must_be_instance_of HotelBooking::Reservation
      end
    end

    it 'returns empty array if the room does not have any reservations' do
      room_reservations = []
      front_desk.reservations.each do |res|
        res.room == room
        room_reservations << res
      end
      if room_reservations.empty?
        reservation_list = front_desk.room_reservations(room, period)
      end
      expect(reservation_list).must_equal []

    end

    it " can find the reservations of the one room that fall in that date range" do
       # return empty array
    end

  end

  describe "list date reservations" do
    let(:date) {Date.new(2020, 03, 27)}
    it "takes a Date and returns a list of Reservations" do
      reservation_list = front_desk.date_reservations(date)
      expect(reservation_list).must_be_kind_of Array
      reservation_list.each do |res|
        res.must_be_kind_of Reservation
      end
    end
  end

  xdescribe 'find available room' do
    before do
      @reservation = front_desk.make_reservation(start_date: Date.today, end_date: (Date.today + 3))
    end
    let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }

    it 'can create a list of rooms with no reservations in date_range' do
      expect(front_desk.available_rooms(date_range)).must_be_instance_of Array
    end

    it 'returns a list of available rooms' do
      available_rooms = front_desk.available_rooms(date_range) 
      available_rooms.each do |room|
        room.must_be_kind_of HotelBooking::Room
      end
    end

    # it 'returns all rooms if no reservations are made on that date' do
    #   future_period = HotelBooking::DateRange.new(start_date: Date.new(2021, 03, 01), end_date: Date.new(2021, 03, 30))

    #   available_rooms = front_desk.available_rooms(future_period)

    #   expect(available_rooms).must_equal front_desk.rooms

    # end

    # xit 'returns an empty array if no room is available' do
    #   available_rooms = []
    #   front_desk.rooms.each do |room|
    #     front_desk.reservations.each do |reservation| 
    #       room_res = reservation.room_reservations(room, date_range) 
    #       available_rooms << room if room_res.lenght == 0
    #     end
    #   end
    #   if available_rooms.empty?
    #     rooms_list = front_desk.available_rooms(date_range)
    #   end
    #   expect(rooms_list).must_equal []

    # end

  end

  xdescribe "make reservation for specific room" do
    let(:room) {front_desk.rooms[7]}
    let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }

    it "I can make a reservation of a room for a given date range" do
      res = front_desk.make_room_reservation(date_range, room)
      expect(res).must_be_instance_of HotelBooking::Reservation
    end
    
    it "room will not be part of any other reservation overlapping that date range" do

      # res_1 = front_desk.make_room_reservation(date_range, room)
      
    end

  end


end
    