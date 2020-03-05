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

    it "stores an array of its reservations" do
      @coordinator01.rooms.each do |room|
        expect(room.bookings).must_be_instance_of Array
      end
    end
  end

  describe "#build_rooms" do
    it "returns an array" do
      quantity = 5
      expect(@coordinator01.build_rooms(quantity)).must_be_instance_of Array
      expect(@coordinator01.build_rooms(quantity).length).must_equal quantity
    end

    it "stores Room instance in each element" do
      built01 = @coordinator01.build_rooms(5)
      built01.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
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


  describe "#find_availabile_rooms" do
    before do
      @start_date = Date.today + 5
      @end_date = Date.today + 10
      @date_range = Hotel::DateRange.new(@start_date,@end_date)
    end

    it "returns an array" do
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      expect(available_rooms).must_be_instance_of Array
    end

    it "stores Room instances in the array" do
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      available_rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end

    it "returns the correct number of available rooms when there are no reservations" do
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      expect(available_rooms.length).must_equal 20
    end

    it "returns the correct number of available rooms when there are reservations" do
      @coordinator01.make_reservation(@start_date, @end_date)
      @coordinator01.make_reservation(@start_date, @end_date)
      @coordinator01.make_reservation(Date.today + 10, Date.today + 12)
      @coordinator01.make_reservation(Date.today + 1, Date.today + 2)
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      expect(available_rooms.length).must_equal 18
    end

    it "should not include rooms that have reservations in the given date_range" do
      @coordinator01.make_reservation(@start_date, @end_date)
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      available_rooms.each do |room|
        room.bookings.each do |booking|
          expect(booking.date_range.overlapping(@date_range)).must_equal false
        end
      end
    end
  end

  describe "#make_reservation" do
    before do
      @start_date = Date.today + 5
      @end_date = Date.today + 10
      @date_range = Hotel::DateRange.new(@start_date,@end_date)
    end

    it "returns a Reservation" do
      new_reservation = @coordinator01.make_reservation(@start_date, @end_date)
      expect(new_reservation).must_be_instance_of Hotel::Reservation
    end

    it "stores the room_id in the Reservation returned" do
      new_reservation = @coordinator01.make_reservation(@start_date, @end_date)
      expect(new_reservation.room_id).must_equal 1
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

  describe "#find_reservations_by_date" do
    before do
      start_date = Date.today + 5
      end_date = Date.today + 10
      @coordinator01.make_reservation(start_date, end_date)
    end

    it "returns an array" do
      date10 = Date.today + 7
      expect(@coordinator01.find_reservations_by_date(date10)).must_be_instance_of Array
    end

    it "returns empty array when the date is not included" do
      date11 = Date.today + 1
      expect(@coordinator01.find_reservations_by_date(date11)).must_equal []
    end

    it "stores Reservation instances in the returned array" do
      date10 = Date.today + 7
      found_reservations = @coordinator01.find_reservations_by_date(date10)
      found_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe "#find_reservations_room_date" do
    before do
      @start_date = Date.today + 5
      @end_date = Date.today + 10
      @date_range = Hotel::DateRange.new(@start_date,@end_date)
      new_reservation = @coordinator01.make_reservation(@start_date, @end_date)
      @room_id = new_reservation.room_id
    end

    it "returns an array of reservations" do
      reservation_list = @coordinator01.find_reservations_room_date(@room_id,@date_range)
      expect(reservation_list).must_be_instance_of Array
    end

    it "stores Reservation instances in each element of the array" do
      reservation_list = @coordinator01.find_reservations_room_date(@room_id,@date_range)
      reservation_list.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe "#find_reservations_range" do
    before do
      @start_date = Date.today + 5
      @end_date = Date.today + 10
      @date_range = Hotel::DateRange.new(@start_date,@end_date)
      @coordinator01.make_reservation(@start_date, @end_date)
    end

    it "returns an array of reservations" do
      reservations_range = @coordinator01.find_reservations_range(@date_range)
      expect(reservations_range).must_be_instance_of Array
      expect(reservations_range.length).must_equal 1
    end

    it "returns the correct quantity of reservations" do
      @coordinator01.make_reservation(Date.today + 5, Date.today + 6)
      @coordinator01.make_reservation(Date.today + 8, Date.today + 18)
      reservations_range = @coordinator01.find_reservations_range(@date_range)
      expect(reservations_range).must_be_instance_of Array
      expect(reservations_range.length).must_equal 3
    end
   end
end


