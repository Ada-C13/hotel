require_relative 'test_helper'

describe "hotel reception" do
  before do
    @reception = Hotel::HotelReception.new
  end

  describe 'initialize' do
    it "can be instantiated" do
      expect(@reception).must_be_instance_of Hotel::HotelReception
      expect(@reception).must_respond_to :rooms
      expect(@reception).must_respond_to :reservations
    end

    it "has an array of Room objects" do
      my_rooms = @reception.rooms
      expect(my_rooms).must_be_instance_of Array
      expect(my_rooms).wont_be_empty
      expect(my_rooms.first).must_be_instance_of Hotel::Room
      expect(my_rooms.first.id).must_equal 1
      expect(my_rooms.last.id).must_equal 20
      expect(my_rooms.first.cost).must_equal 200
      expect(my_rooms.length).must_equal 20
    end

    it "has an empty array of reservation objects as an attribute" do
      expect(@reception.reservations).must_be_instance_of Array
      expect(@reception.reservations).must_be_empty
    end
  end

  describe "available rooms method" do
    before do
      check_in_time = Date.new(2020, 2, 1)
      check_out_time = Date.new(2020, 2, 3)
      room = @reception.rooms[0]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = Date.new(2020, 2, 14)
      check_out_time = Date.new(2020, 2, 15)
      room = @reception.rooms[1]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    it "will list an array of the available rooms for a given dates" do
      check_in_time = Date.new(2020, 2, 1)
      check_out_time = Date.new(2020, 2, 2)
      my_rooms = @reception.available_rooms(check_in_time, check_out_time)
      my_room_ids = my_rooms.map { |room| room.id }

      expect(my_rooms).must_be_instance_of Array
      expect(my_rooms.first).must_be_instance_of Hotel::Room
      expect(my_rooms.length).must_equal 19
      expect(my_room_ids.include?(@reception.rooms[0].id)).must_equal false
    end

    it "will list an empty array if there are no avail rooms for dates" do
      # TODO
    end

    it "will"
  end

  describe "find reservation" do
    before do
      check_in_time = Date.new(2020, 2, 1)
      check_out_time = Date.new(2020, 2, 3)
      room = @reception.rooms[0]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = Date.new(2020, 2, 14)
      check_out_time = Date.new(2020, 2, 15)
      room = @reception.rooms[1]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    it "will return the reservation with the id given" do
      my_reservation_id = @reception.reservations[1].id
      my_reservation = @reception.find_reservation(my_reservation_id)

      expect(my_reservation).must_be_instance_of Hotel::Reservation
      expect(my_reservation.room.id).must_equal 2
    end
  end

  describe "list reservations method" do
    before do
      check_in_time = Date.new(2020, 2, 1)
      check_out_time = Datenew(2020, 2, 3)
      room = @reception.rooms[0]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = Date.new(2020, 2, 14)
      check_out_time = Date.new(2020, 2, 16)
      room = @reception.rooms[1]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    it "will return an array of reservation objects using a date" do
      date = Date.new(2020, 2, 14)

      expect(@reception.list_reservations(date: date)).must_be_instance_of Array
      expect(@reception.list_reservations(date: date).first).must_be_instance_of Hotel::Reservation
    end

    it "will return an array of reservation objects using a date and a room id" do
      room_id = @reception.rooms[0].id
      date = Date.new(2020, 2, 2)

      room_id2 = @reception.rooms[1].id
      date2 = Date.new(2020, 2, 14)

      expect(@reception.list_reservations(date: date, room_id: room_id)).must_be_instance_of Array
      expect(@reception.list_reservations(room_id: room_id, date: date)).wont_be_empty
      expect(@reception.list_reservations(room_id: room_id, date: date).first).must_be_instance_of Hotel::Reservation

      expect(@reception.list_reservations(room_id: room_id2, date: date2)).wont_be_empty
      expect(@reception.list_reservations(room_id: room_id2, date: date2)[0]).must_be_instance_of Hotel::Reservation
    end
    
    it "will find the correct reservation with date" do
      date = Date.new(2020, 2, 14)

      expect(@reception.list_reservations(date: date).first.room.id).must_equal 2
    end

    it "will return the correct reservation with date and room id" do
      date = Date.new(2020, 2, 14)
      room_id = @reception.rooms[1].id
      my_reservations = @reception.list_reservations(date: date, room_id: room_id)

      puts my_reservations
      expect(my_reservations).must_be_instance_of Array
      expect(my_reservations.first).must_be_instance_of Hotel::Reservation
      expect(my_reservations.first.room.id).must_equal 2
    end

    it "will return empty array if there are no reservations with that criteria" do
      date = Date.new(2020, 1, 2)
      room_id = 5
      expect(@reception.list_reservations(date: date, room_id: room_id)).must_be_empty
      expect(@reception.list_reservations(date: date)).must_be_empty
    end
  end

  describe "make reservation method" do
    before do
      check_in_time = Date.new(2020, 2, 1)
      check_out_time = Date.new(2020, 2, 3)
      @reception.make_reservation(check_in_time, check_out_time)
    end
    it "edits the reservations array" do
      expect(@reception.reservations).wont_be_empty
      expect(@reception.reservations.length).must_equal 1
      expect(@reception.reservations.first).must_be_instance_of Hotel::Reservation
    end

    it "will reserve the first room available" do
      check_in_time = Date.new(2020, 2, 2)
      check_out_time = Date.new(2020, 2, 3)
      @reception.make_reservation(check_in_time, check_out_time)
      my_reservations = @reception.reservations

      expect(my_reservations.length).must_equal 2
      expect(my_reservations.last.id).wont_equal @reception.reservations.first.id
      expect(my_reservations.last.date_range.overlap?(my_reservations.first.date_range)).must_equal true
      expect(my_reservations.last.room.id).wont_equal @reception.reservations.first.room.id
    end

    it "will raise an exception if there are no rooms available" do
      my_reception = Hotel::HotelReception.new

      check_in_time = Date.new(2020, 2, 14)
      check_out_time = Date.new(2020, 2, 15)
      20.times do |i|
        room = my_reception.rooms[i]
        my_reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
      end

      expect(my_reception.reservations.length).must_equal 20
      expect{
        my_reception.make_reservation(check_in_time, check_out_time)
      }.must_raise ArgumentError
    end
  end
end