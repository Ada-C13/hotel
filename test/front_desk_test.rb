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

    it "keeps track of hotel blocks" do
      expect(front_desk).must_respond_to :hotel_blocks
      expect(front_desk.hotel_blocks).must_be_kind_of Array
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

  describe "create hotel block" do
    let(:start_date) { Date.new(2020, 05, 01)}
    let(:end_date) { Date.new(2020, 05, 05)}
    let(:range) { HotelBooking::DateRange.new(start_date: start_date, end_date: end_date) }
    let(:hotel_block) { HotelBooking::HotelBlock.new(name: "Wedding: Johnson-Poe", date_range: range, room_count: 3, discount_rate: 0.9) }
    
    it "creates a hotel block with predefined number of available rooms and a discount rate" do
      name = "your wedding"
      block = front_desk.create_hotel_block(name, range, 3)
      expect(block).must_be_instance_of HotelBooking::HotelBlock
    end

    it "block rooms would be unavailable" do
      available_rooms = front_desk.available_rooms(range)
      hotel_block.rooms.each  do |b_room|
        expect(available_rooms.include?(b_room)).must_equal false
      end
    end

    it "raises an argument error if sufficient rooms are not available in given date range" do
      test_range = HotelBooking::DateRange.new(start_date: Date.new(2020, 5, 2), end_date: Date.new(2020, 5, 4))
      17.times do 
        front_desk.make_reservation(test_range)
      end
      expect { front_desk.create_hotel_block("blah blah", test_range, 5, 0.9) }.must_raise ArgumentError
    end
  end

  describe 'find available rooms' do
    let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }
    let(:reservation) { front_desk.make_reservation(date_range) }

    let(:start_date) { Date.new(2020, 3, 23)}
    let(:end_date) { Date.new(2020, 3, 27)}
    let(:date_range_b) { HotelBooking::DateRange.new(start_date: start_date, end_date: end_date) }
    let(:room_b) { HotelBooking::Room.new(number: 2, in_block: true) } 
    let(:block_b) { HotelBooking::HotelBlock.new(name: "me", date_range: date_range_b, room_count: 1 , discount_rate: 0.9)}
    let(:reservation_b) {HotelBooking::Reservation.new(date_range: date_range_b, room: room_b, block: block_b)}

    it 'can create a list of rooms with no reservations in date_range' do
      expect(front_desk.available_rooms(date_range)).must_be_instance_of Array
    end

    it 'returns a list of available rooms' do
      available_rooms = front_desk.available_rooms(date_range) 
      available_rooms.each do |room|
        expect(room).must_be_kind_of HotelBooking::Room
      end
    end

    it "does not include rooms with an overlapping reservation" do
      front_desk.reservations.each do |res|
        if res.date_range.overlap?(date_range) 
          expect(!(front_desk.available_rooms(date_range).include?(res.room))).must_equal true
        end
      end
    end

    it "does not include rooms in a block at that time range" do
      front_desk.hotel_blocks.each do |block|
        if block.date_range.overlap?(date_range)
          block.rooms.each do |b_room|
            expect(!(front_desk.available_rooms(date_range).include?(b_room))).must_equal true
          end
        end
      end
    end

    it 'returns all rooms if no reservations are made on that date' do
      overlapping = []
      front_desk.reservations.each do |res|
        if res.date_range.overlap?(date_range)
          overlapping << res
        end
      end
      if overlapping == 0
        expect(front_desk.available_rooms(date_range).length).must_equal 20
      end
    end

    it 'returns an empty array if no room is available' do
      20.times do
        front_desk.make_reservation(date_range)
      end
      expect(front_desk.available_rooms(date_range).length).must_equal 0
    end

  end

  describe "make reservation" do
    let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }

    it 'raises argument error if no room is available' do
      if front_desk.available_rooms(date_range).length == 0
        expect(front_desk.make_reservation(date_range)).must_raise ArgumentError
      end
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

  describe "make block reservation" do
    before do
      start_date = Date.new(2020, 3, 23)
      end_date = Date.new(2020, 3, 27)
      date_range_b =HotelBooking::DateRange.new(start_date: start_date, end_date: end_date) 
      room_b = HotelBooking::Room.new(number: 2, in_block: true) 
      name_b = "your wedding"
      @block_b = front_desk.create_hotel_block(name_b, date_range_b, 2, 0.9)
    end

    it "can create a reservation for a block room" do 
      expect(front_desk.make_block_reservation("your wedding")).must_be_instance_of HotelBooking::Reservation
    end

    it "I can check whether a given block has any rooms available" do
      block_res = front_desk.make_block_reservation("your wedding")
      available_rooms = @block_b.rooms.reject { |block_room| front_desk.list_room_reservations(block_room, @block_b.date_range).length != 0 }
      expect(available_rooms.length != 0).must_equal true
    end

    it "can only reserve that room from a hotel block for the full duration of the block" do
      block_res = front_desk.make_block_reservation("your wedding")
      expect(block_res.date_range).must_equal @block_b.date_range
      
    end
  end

  describe "make reservation for specific room" do
    let(:room) {front_desk.rooms[7]}
    let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }

    it "I can make a reservation of a room for a given date range" do
      res = front_desk.make_room_reservation(date_range, room)
      expect(res).must_be_instance_of HotelBooking::Reservation
    end
    
    it "room will not be part of any other reservation overlapping that date range" do
      res = front_desk.make_room_reservation(date_range, room)
      overlapping = []
      front_desk.reservations.each do |reserv|
        if reserv.date_range.overlap?(date_range)
          overlapping << reserv
        end
      end
      expect(overlapping.include?(res)).must_equal true
    end

    it "raises argument eror if the room is not available" do
      front_desk.make_room_reservation(date_range, room)
      overlapping = []
      front_desk.reservations.each do |reserv|
        if reserv.date_range.overlap?(date_range) && reserv.room == room
          overlapping << reserv
        end
      end
      if overlapping != 0
        expect { front_desk.make_room_reservation(date_range, room)}.must_raise ArgumentError
      end
    end

  end

  describe "list room reservations" do
    let(:period) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 15)) }
    let(:room) {HotelBooking::Room.new(number: 2)}

    it "returns the list of reservation a rooms has in a time period" do
      reservation_list = front_desk.list_room_reservations(room, period)
      expect(reservation_list).must_be_kind_of Array
      reservation_list.each do |res|
        expect(res).must_be_instance_of HotelBooking::Reservation
        expect(res.room).must_equal room
        expect(res.date_range.overlap?(period)).must_equal true

      end
    end

    it 'returns empty array if the room does not have any reservations' do
      room_reservations = []
      front_desk.reservations.each do |res|
        res.room == room
        room_reservations << res
      end
      if room_reservations.empty?
        reservation_list = front_desk.list_room_reservations(room, period)
      end
      expect(reservation_list).must_equal []

    end
  end

  describe "list date reservations" do
    let(:date) {Date.new(2020, 10, 27)}
    let(:date_range1) { HotelBooking::DateRange.new(start_date: Date.new(2020, 10, 25), end_date: Date.new(2020, 10, 29)) }
    let(:date_range2) { HotelBooking::DateRange.new(start_date: Date.new(2020, 10, 26), end_date: Date.new(2020, 10, 28)) }
    it "takes a Date and returns a list of Reservations" do
      front_desk.make_reservation(date_range1)
      front_desk.make_reservation(date_range2)
      reservation_list = front_desk.list_date_reservations(date)
      expect(reservation_list).must_be_kind_of Array
      reservation_list.each do |res|
        expect(res).must_be_kind_of HotelBooking::Reservation
      end
      expect(reservation_list.length).must_equal 2
    end
    
    it "returns empty array if the date does not have any reservations" do
      date_reservations = []
      front_desk.reservations.each do |res|
        res.date_range.include?(date)
        date_reservations << res
      end
      if date_reservations.empty?
        reservation_list = front_desk.list_date_reservations(date)
      end
      expect(reservation_list).must_equal []
    end

  end

end
    