require_relative 'test_helper'

describe Hotel::SystemCoordinator do
  before do
    @coordinator01 = Hotel::SystemCoordinator.new
  end

  describe "@rooms" do
    it "is an instance variable @rooms that is an array" do
      expect(@coordinator01.rooms).must_be_instance_of Array
    end

    it "stores each element in the @rooms array as an instance of Room" do
      @coordinator01.rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end

    it "stores the correct room ids from 1 ~20" do
      @coordinator01.rooms.each_with_index do |room,i|
        expect(room.room_id).must_equal (i+1)
      end
    end

    it "stores the correct cost $200 in each room instance" do
      @coordinator01.rooms.each do |room|
        expect(room.cost).must_be_instance_of Float
        expect(room.cost).must_equal 200.00
      end
    end
  end

  describe "@reservations" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @room_id = 10
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
      @coordinator01.reservations << @reservation01
    end
    # let (:reservation01) {
    #   Hotel::Reservation.new(Hotel::DateRange.new(Date.today + 5, Date.today + 10), 10)
    # }

    it "returns an array of reservations that include that date" do
      expect(@coordinator01.reservations).must_be_instance_of Array
    end

    it "stores Reservation instances in each element of @reservations" do
      @coordinator01.reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
        expect(reservation.date_range).must_be_instance_of Hotel::DateRange
        expect(reservation.room_id).must_equal @room_id
      end
    end

    it "stores the correct room_id in each of the Reservation instances" do
      expect(@coordinator01.reservations[0].room_id).must_equal @room_id
    end
  end

  describe "#list_rooms" do
    it "returns an Array with size of 20" do
      expect(@coordinator01.list_rooms).must_be_instance_of Array
      expect(@coordinator01.list_rooms.length).must_equal 20
    end

    it "stores Room instance in each array element" do
      @coordinator01.list_rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end
  end

  describe "#find_reservations_by_date" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @room_id = 10
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
      @coordinator01.reservations << @reservation01

      @found_reservations = @coordinator01.find_reservations_by_date(Date.today + 7)
    end

    it "returns an array" do
      expect(@found_reservations).must_be_instance_of Array
      # expect(@coordinator01.find_reservation_by_date(date10)).must_be_instance_of Array
    end

    it "returns what? when the date is not included" do
      date11 = Date.today + 1
      expect(@coordinator01.find_reservations_by_date(date11)).must_equal []
    end

    it "stores Reservation instances in the returned array" do
      @found_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe "#find_reservations_room_date" do
    before do
      @room_id = 10
      @room01 = Hotel::Room.new(@room_id)
      
      @date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @reservation01 = Hotel::Reservation.new(@date_range, @room_id)
      @coordinator01.reservations << @reservation01
      @room01.add_booking_to_room(@reservation01)
      
      @reservation_list = @coordinator01.find_reservations_room_date(@room_id, @date_range)
    end

    it "returns an array of reservations" do
      expect(@reservation_list).must_be_instance_of Array
    end

    it "stores Reservation instances in each element of the array" do
      @reservation_list.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe "#find_availabile_rooms" do
    before do
      @room_id = 10
      @room01 = Hotel::Room.new(@room_id)
      
      @date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @reservation01 = Hotel::Reservation.new(@date_range, @room_id)
      @coordinator01.reservations << @reservation01
      @room01.add_booking_to_room(@reservation01)
      
      @available_rooms = @coordinator01.find_availabile_rooms(@date_range)
    end

    it "returns an array" do
      expect(@available_rooms).must_be_instance_of Array
    end

    it "stores Room instances in the array" do
      @available_rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end

    it "represents number of rooms as the size of the array" do
      expect(@available_rooms.length).must_equal 19
    end

    it "should not include rooms that have reservations in the given date_range" do
      @available_rooms.each do |room|
        room.bookings.each do |booking|
          expect(booking.date_range.overlapping(@date_range)).must_equal false
        end
      end
    end
  end

  describe "#make_reservation" do
    before do
      room01 = Hotel::Room.new(10)
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      reservation01 = Hotel::Reservation.new(date_range, 10)
      room01.add_booking_to_room(reservation01)
      @coordinator01.reservations << reservation01
      


      start_date = Date.today + 5
      end_date = Date.today + 10
      @reservation_range = Hotel::DateRange.new(start_date, end_date)
      @new_rs = @coordinator01.make_reservation(start_date, end_date)
    end

    it "returns a Reservation" do
      expect(@new_rs).must_be_instance_of Hotel::Reservation
    end

    it "stores the room_id in the Reservation returned" do
      expect(@new_rs.room_id).must_be_instance_of Integer
    end

    it "reserves a room that will not be part of any other reservation overlapping that date range" do
      room_chosen = @coordinator01.find_room(@new_rs.room_id)
      (room_chosen.bookings.length - 1).times do |reservation|
        expect(reservation.date_range).wont_equal @new_rs.date_range
      end
    end
  end

  describe "#find_room" do
    it "returns an instance of Room" do
      expect(@coordinator01.find_room(10)).must_be_instance_of Hotel::Room
    end

    it "returns nil??? if an invalid room_id is passed in" do
      expect(@coordinator01.find_room(999)).must_be_nil
    end
  end

end