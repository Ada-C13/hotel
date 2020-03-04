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

    it "has an array of rooms as an attribute" do
      expect(@reception.rooms).must_be_instance_of Array
      expect(@reception.rooms).wont_be_empty
      expect(@reception.rooms.length).must_equal 20
    end

    it "has an empty array of reservation objects as an attribute" do
      expect(@reception.reservations).must_be_instance_of Array
      expect(@reception.reservations).must_be_empty
    end
  end

  describe "make reservation method" do
    it "edits the reservations array" do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      @reception.make_reservation(check_in_time, check_out_time)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      @reception.make_reservation(check_in_time, check_out_time)

      expect(@reception.reservations).wont_be_empty
      expect(@reception.reservations.length).must_equal 2
      expect(@reception.reservations[0]).must_be_instance_of Hotel::Reservation
    end

    it "will reserve the first room available" do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      my_reservation = Hotel::Reservation.new(check_in_time, check_out_time, 1)
      @reception.make_reservation(check_in_time, check_out_time)

      expect(@reception.reservations[0].room_id).must_equal my_reservation.room_id
    end
  end

  describe "find available room" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 1)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 2)
    end

    it "will list an array of the available rooms for a given date" do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 2]
      my_rooms = @reception.available_rooms(check_in_time, check_out_time)

      expect(my_rooms).must_be_instance_of Array
      expect(my_rooms).wont_include 1
      expect(my_rooms).must_include 2
    end
  end

  describe "find reservation" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 1)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 2)
    end

    it "will return the reservation with the id given" do
      my_reservation_id = @reception.reservations[1].id
      my_reservation = @reception.find_reservation(my_reservation_id)

      expect(my_reservation).must_be_instance_of Hotel::Reservation
      expect(my_reservation.room_id).must_equal 2
    end
  end

  describe "reservations by room date method" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 1)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 2)
    end

    it "will return an array of reservation objects" do
      room = 2
      date = Date.new(2020, 2, 14)
    
      room2 = 1
      date2 = Date.new(2020, 2, 2)

      expect(@reception.reservations_by_room_date(room, date)).must_be_instance_of Array
      expect(@reception.reservations_by_room_date(room, date)[0]).must_be_instance_of Hotel::Reservation
      expect(@reception.reservations_by_room_date(room2, date2)).must_be_instance_of Hotel::Reservation
    end
    
    it "will return the correct reservation object" do
      date = Date.new(2020, 2, 14)
      room = 2
      my_reservation = @reception.reservations[1]

      expect(@reception.reservations_by_room_date(room, date)).must_equal my_reservation
    end

    it "will return empty array if there are no reservations with that criteria" do
      date = Date.new(2020, 1, 2)
      expect(@reception.reservations_by_room_date(5, date)).must_be_empty
    end
  end

  describe "reservations by date method" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 1)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, 2)
    end

    it "will return an array of reservation objects" do
      date = Date.new(2020, 2, 14)

      expect(@reception.reservations_by_date(date)).must_be_instance_of Array
      expect(@reception.reservations_by_date(date)[0]).must_be_instance_of Hotel::Reservation
    end

    it "will find the correct reservation" do
      date = Date.new(2020, 2, 14)

      expect(@reception.reservations_by_date(date))
    end

    it "will return empty array when no reservation found" do
      date = Date.new(2020, 1, 2)

      expect(@reception.reservations_by_date(date)).must_be_empty
    end
  end
end