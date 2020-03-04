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
      expect(@reception.rooms).must_be_instance_of Array
      expect(@reception.rooms).wont_be_empty
      expect(@reception.rooms[0]).must_be_instance_of Hotel::Room
      expect(@reception.rooms.length).must_equal 20
    end

    it "has an empty array of reservation objects as an attribute" do
      expect(@reception.reservations).must_be_instance_of Array
      expect(@reception.reservations).must_be_empty
    end
  end

  describe "find available room" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      room = Hotel::Room.new(1, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      room = Hotel::Room.new(2, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    it "will list an array of the available rooms for a given date" do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 2]
      my_rooms = @reception.available_rooms(check_in_time, check_out_time)
      my_room_ids = my_rooms.map { |room| room.id }

      expect(my_rooms).must_be_instance_of Array
      expect(my_room_ids.length).must_equal 19
      expect(my_rooms[0]).must_be_instance_of Hotel::Room
      expect(my_rooms[0].id).wont_equal 1
    end
  end

  describe "find reservation" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      room = Hotel::Room.new(1, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      room = Hotel::Room.new(2, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    it "will return the reservation with the id given" do
      my_reservation_id = @reception.reservations[1].id
      my_reservation = @reception.find_reservation(my_reservation_id)

      expect(my_reservation).must_be_instance_of Hotel::Reservation
      expect(my_reservation.room.id).must_equal 2
    end
  end

  describe "reservations by room date method" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      room = Hotel::Room.new(1, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 15]
      room = Hotel::Room.new(2, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    # it "will return an array of Reservation objects" do
    #   room_id = Hotel::Room.new(1, 200).id
    #   date = Date.new(2020, 2, 2)

    #   room_id2 = Hotel::Room.new(2, 200).id
    #   date2 = Date.new(2020, 2, 14)

    #   expect(@reception.reservations_by_room_date(room_id, date)).must_be_instance_of Array
    #   expect(@reception.reservations_by_room_date(room_id, date)).wont_be_empty
    #   expect(@reception.reservations_by_room_date(room_id, date)[0]).must_be_instance_of Hotel::Reservation

    #   expect(@reception.reservations_by_room_date(room_id2, date2)).wont_be_empty
    #   expect(@reception.reservations_by_room_date(room_id2, date2)[0]).must_be_instance_of Hotel::Reservation
    # end
    
    # it "will return the correct reservation objects" do
    #   date = Date.new(2020, 2, 14)
    #   room_id = 1
    #   my_reservations = @reception.reservations_by_room_date(room_id, date)


    #   expect(my_reservations).must_be_instance_of Array
    #   expect(my_reservations[0]).must_be_instance_of Hotel::Reservation
    #   expect(my_reservations[0].room.id).must_equal 1
    # end

    # it "will return empty array if there are no reservations with that criteria" do
    #   date = Date.new(2020, 1, 2)
    #   room_id = 5
    #   expect(@reception.reservations_by_room_date(room_id, date)).must_be_empty
    # end
  end

  # describe "reservations by date method" do
  #   before do
  #     check_in_time = [2020, 2, 1]
  #     check_out_time = [2020, 2, 3]
  #     room = Hotel::Room.new(1, 200)
  #     @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

  #     check_in_time = [2020, 2, 14]
  #     check_out_time = [2020, 2, 16]
  #     room = Hotel::Room.new(2, 200)
  #     @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
  #   end

  #   it "will return an array of reservation objects" do
  #     date = Date.new(2020, 2, 14)

  #     expect(@reception.reservations_by_date(date)).must_be_instance_of Array
  #     expect(@reception.reservations_by_date(date)[0]).must_be_instance_of Hotel::Reservation
  #   end

  #   it "will find the correct reservation" do
  #     date = Date.new(2020, 2, 14)

  #     expect(@reception.reservations_by_date(date))
  #   end

  #   it "will return empty array when no reservation found" do
  #     date = Date.new(2020, 1, 2)

  #     expect(@reception.reservations_by_date(date)).must_be_empty
  #   end
  # end

  describe "list reservations method" do
    before do
      check_in_time = [2020, 2, 1]
      check_out_time = [2020, 2, 3]
      room = Hotel::Room.new(1, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)

      check_in_time = [2020, 2, 14]
      check_out_time = [2020, 2, 16]
      room = Hotel::Room.new(2, 200)
      @reception.reservations << Hotel::Reservation.new(check_in_time, check_out_time, room)
    end

    it "will return an array of reservation objects" do
      date = Date.new(2020, 2, 14)

      expect(@reception.list_reservations(date: date)).must_be_instance_of Array
      expect(@reception.list_reservations(date: date)[0]).must_be_instance_of Hotel::Reservation
    end

    it "will find the correct reservation" do
      date = Date.new(2020, 2, 14)

      expect(@reception.list_reservations(date: date)[0].room.id).must_equal 2
    end

    it "will return empty array when no reservation found" do
      date = Date.new(2020, 1, 2)

      expect(@reception.list_reservations(date: date)).must_be_empty
    end


    it "will return an array of Reservation objects" do
      room_id = Hotel::Room.new(1, 200).id
      date = Date.new(2020, 2, 2)

      room_id2 = Hotel::Room.new(2, 200).id
      date2 = Date.new(2020, 2, 14)

      expect(@reception.list_reservations(date: date, room_id: room_id)).must_be_instance_of Array
      expect(@reception.list_reservations(room_id: room_id, date: date)).wont_be_empty
      expect(@reception.list_reservations(room_id: room_id, date: date)[0]).must_be_instance_of Hotel::Reservation

      expect(@reception.list_reservations(room_id: room_id2, date: date2)).wont_be_empty
      expect(@reception.list_reservations(room_id: room_id2, date: date2)[0]).must_be_instance_of Hotel::Reservation
    end
    
    it "will return the correct reservation objects" do
      date = Date.new(2020, 2, 14)
      room_id = 2
      my_reservations = @reception.list_reservations(date: date, room_id: room_id)

      expect(my_reservations).must_be_instance_of Array
      expect(my_reservations[0]).must_be_instance_of Hotel::Reservation
      expect(my_reservations[0].room.id).must_equal 2
    end

    it "will return empty array if there are no reservations with that criteria" do
      date = Date.new(2020, 1, 2)
      room_id = 5
      expect(@reception.list_reservations(date: date, room_id: room_id)).must_be_empty
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
      my_room = Hotel::Room.new(1, 200)
      my_reservation = Hotel::Reservation.new(check_in_time, check_out_time, my_room)
      @reception.make_reservation(check_in_time, check_out_time)

      expect(@reception.reservations[0].room.id).must_equal my_reservation.room.id
    end
  end
end