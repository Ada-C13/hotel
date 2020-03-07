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
    it "increases the number of rooms" do
      before = @coordinator01.rooms.length
      @coordinator01.build_rooms(5)
      expect(@coordinator01.rooms.length).must_equal before + 5
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

    it "stores Room instances or Block instances in the array" do
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      available_rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room || Hotel::Block
      end
    end

    it "returns the correct number of available rooms when there are no reservations" do
      available_rooms = @coordinator01.find_availabile_rooms(@date_range)
      expect(available_rooms.length).must_equal 20
    end

    it "returns the correct number of available rooms when there are reservations" do
      @coordinator01.make_reservation(@start_date, @end_date)
      expect(@coordinator01.find_availabile_rooms(@date_range).length).must_equal 19
      @coordinator01.make_reservation(Date.today + 10, Date.today + 12)
      @coordinator01.make_reservation(Date.today + 1, Date.today + 2)
      expect(@coordinator01.find_availabile_rooms(@date_range).length).must_equal 19
      @coordinator01.make_reservation(@start_date, @end_date)
      expect(@coordinator01.find_availabile_rooms(@date_range).length).must_equal 18
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

    it "returns the correct number of available rooms when there are blocks" do
      @coordinator01.make_block(@date_range, 3, 150)
      expect(@coordinator01.find_availabile_rooms(@date_range).length).must_equal 20
      range02 = Hotel::DateRange.new(Date.today + 5, Date.today + 7)
      expect(@coordinator01.find_availabile_rooms(range02).length).must_equal 17
      range03 = Hotel::DateRange.new(Date.today + 5, Date.today + 15)
      expect(@coordinator01.find_availabile_rooms(range03).length).must_equal 17
      range04 = Hotel::DateRange.new(Date.today + 3, Date.today + 12)
      expect(@coordinator01.find_availabile_rooms(range04).length).must_equal 17
      @coordinator01.make_block(@date_range, 5, 100)
      expect(@coordinator01.find_availabile_rooms(@date_range).length).must_equal 20
      expect(@coordinator01.find_availabile_rooms(range02).length).must_equal 12
    end

    it "raises NoAvailabilityError when there are no rooms available" do
      20.times do 
        @coordinator01.make_reservation(@start_date, @end_date)
      end
      expect{@coordinator01.make_reservation(@start_date, @end_date)}.must_raise NoAvailabilityError
    end
  end

  describe "#find_block_rooms" do
    before do
      @start_date = Date.today + 5
      @end_date = Date.today + 10
      @date_range = Hotel::DateRange.new(@start_date,@end_date)
    end

    it "returns an array" do
      available_rooms = @coordinator01.find_block_rooms(@date_range)
      expect(available_rooms).must_be_instance_of Array
    end

    it "stores Room instances in the array" do
      available_rooms = @coordinator01.find_block_rooms(@date_range)
      available_rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end

    it "returns the correct number of available rooms when there are no reservations" do
      available_rooms = @coordinator01.find_block_rooms(@date_range)
      expect(available_rooms.length).must_equal 20
    end

    it "returns the correct number of available rooms when there are reservations" do
      @coordinator01.make_reservation(@start_date, @end_date)
      expect(@coordinator01.find_block_rooms(@date_range).length).must_equal 19
      @coordinator01.make_reservation(Date.today + 10, Date.today + 12)
      @coordinator01.make_reservation(Date.today + 1, Date.today + 2)
      expect(@coordinator01.find_block_rooms(@date_range).length).must_equal 19
      @coordinator01.make_reservation(@start_date, @end_date)
      expect(@coordinator01.find_block_rooms(@date_range).length).must_equal 18
    end

    it "returns the correct number of available rooms when there are blocks" do
      @coordinator01.make_reservation(@start_date, @end_date)
      expect(@coordinator01.find_block_rooms(@date_range).length).must_equal 19
      @coordinator01.make_block(@date_range, 5, 150)
      expect(@coordinator01.find_block_rooms(@date_range).length).must_equal 14
      range02 = Hotel::DateRange.new(@start_date + 2, @end_date + 2)
      @coordinator01.make_block(range02, 3, 180)
      expect(@coordinator01.find_block_rooms(@date_range).length).must_equal 11
    end

    it "should not include rooms that have reservations in the given date_range" do
      @coordinator01.make_reservation(@start_date, @end_date)
      available_rooms = @coordinator01.find_block_rooms(@date_range)
      available_rooms.each do |room|
        room.bookings.each do |booking|
          expect(booking.date_range.overlapping(@date_range)).must_equal false
        end
      end
    end

    it "returns an empty array when there are no rooms available" do
      20.times do 
        @coordinator01.make_reservation(@start_date, @end_date)
      end
      available_rooms = @coordinator01.find_block_rooms(@date_range)
      expect(available_rooms).must_equal []
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

    # it "raises ArgumentError when there are no rooms available" do
    #   20.times do 
    #     @coordinator01.make_reservation(@start_date, @end_date)
    #   end
    #   expect{@coordinator01.make_reservation(@start_date, @end_date)}.must_raise ArgumentError
    # end
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


  describe "#make_block" do
    before do
      @date_range = Hotel::DateRange.new(Date.today + 50, Date.today + 60)
    end

    it "returns an array" do
      block10 = @coordinator01.make_block(@date_range, 5, 100)
      expect(block10).must_be_instance_of Array
    end

    it "returns the correct number of room blocks" do
      block10 = @coordinator01.make_block(@date_range, 5, 100)
      expect(block10.length).must_equal 5
      block20 = @coordinator01.make_block(@date_range, 3, 100)
      expect(block20.length).must_equal 3
    end

    it "returns an array of Block instances that match the date range" do
      block10 = @coordinator01.make_block(@date_range, 5, 100)
      block10.each do |block|
        expect(block).must_be_instance_of Hotel::Block
        expect(block.date_range).must_equal @date_range
      end
    end

    it "has the same block_id for the same block" do
      block10 = @coordinator01.make_block(@date_range, 5, 100)
      block_id = block10[0].block
      block10.each do |block|
        expect(block.block).must_equal block_id
      end
    end

    it "reflects the correct cost that was passed in" do
      block10 = @coordinator01.make_block(@date_range, 5, 100)
      block10.each do |block|
        expect(block.cost).must_equal 100.00
        expect(block.get_total_price).must_equal 1000.00
      end
    end

    it "increases a booking in the room's tracking" do
      block10 = @coordinator01.make_block(@date_range, 2, 100)
      room_id01 = block10[0].room_id
      room_id02 = block10[1].room_id
      room01 = @coordinator01.find_room(room_id01)
      room02 = @coordinator01.find_room(room_id02)
      expect(room01.bookings.length).must_equal 1
      expect(room02.bookings.length).must_equal 1
    end
  end

  describe "#make_specific_block" do
    before do
      @start_date = Date.today + 50
      @end_date = Date.today + 60
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "returns an array" do
      block10 = @coordinator01.make_specific_block(@date_range, [11,12], 100)
      expect(block10).must_be_instance_of Array
    end

    it "returns the correct number of room blocks" do
      block10 = @coordinator01.make_specific_block(@date_range, [20], 180)
      expect(block10.length).must_equal 1
      block20 = @coordinator01.make_specific_block(@date_range, [11,12,13,14,15], 100)
      expect(block20.length).must_equal 5
    end

    it "returns an array of Block instances that match the date range and same block_id" do
      block10 = @coordinator01.make_specific_block(@date_range, [11,12,13], 100)
      block_id = block10[0].block
      block10.each do |block|
        expect(block).must_be_instance_of Hotel::Block
        expect(block.date_range).must_equal @date_range
        expect(block.block).must_equal block_id
      end
    end

    it "reflects the correct cost that was passed in" do
      block10 = @coordinator01.make_specific_block(@date_range, [11,12,13,14,15], 100)
      block10.each do |block|
        expect(block.cost).must_equal 100.00
        expect(block.get_total_price).must_equal 1000.00
      end
    end

    it "raises an Exception when there is a room unavailalblie" do
      reservation10 = @coordinator01.make_reservation(@start_date, @end_date)
      id = reservation10.room_id
      expect{@coordinator01.make_specific_block(@date_range, [id,12,13], 100)}.must_raise NoAvailabilityError
    end
  end


  describe "#check_block_availability" do
    before do
      @start_date = Date.today + 50
      @end_date = Date.today + 60
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "returns true if the given block has any available rooms" do
      block10 = @coordinator01.make_specific_block(@date_range, [1,2], 100)
      block_id=block10[0].block
      @coordinator01.make_reservation(@start_date,@end_date)
      expect(@coordinator01.check_block_availability(block_id)).must_equal true
    end

    it "returns false if there are no available rooms" do
      block10 = @coordinator01.make_specific_block(@date_range, [1,2], 100)
      block_id=block10[0].block
      @coordinator01.make_reservation(@start_date,@end_date)
      @coordinator01.make_reservation(@start_date,@end_date)
      expect(@coordinator01.check_block_availability(block_id)).must_equal false
    end
  end
end




  # describe "rm_available" do
  #   before do
  #     @start_date = Date.today + 5
  #     @end_date = Date.today + 10
  #     @date_range = Hotel::DateRange.new(@start_date,@end_date)
  #     @room01 = @coordinator01.find_room(1)
  #   end

  #   it "returns true if room is available with no reservations" do
  #     expect(@coordinator01.rm_available(@room01, @date_range)).must_equal true
  #     expect(@room01.bookings.length).must_equal 0
  #   end

  #   it "returns true if room is available with exact block match" do
  #     block10 = @coordinator01.make_block(@date_range, 1, 100)
  #     room_id = block10[0].room_id
  #     room = @coordinator01.find_room(room_id)
  #     expect(@coordinator01.rm_available(room, @date_range)).must_equal true
  #     expect(room.bookings.length).must_equal 1
  #   end

  #   it "returns true if room is available with no overlapping reservations" do
  #     reservation10 = @coordinator01.make_reservation(Date.today + 1, Date.today + 3)
  #     room_id = reservation10.room_id
  #     room = @coordinator01.find_room(room_id)
  #     expect(@coordinator01.rm_available(room, @date_range)).must_equal true
  #     expect(room.bookings.length).must_equal 1
  #   end

  #   it "returns false when room has overlapping block" do
  #     range20 = Hotel::DateRange.new(Date.today + 3, Date.today + 7) 
  #     block20 = @coordinator01.make_block(range20, 1, 100)
  #     room_id = block20[0].room_id
  #     room = @coordinator01.find_room(room_id)
  #     expect(@coordinator01.rm_available(room, @date_range)).must_equal false
  #     expect(room.bookings.length).must_equal 1
  #   end

  #   it "returns false when room has overlapping reservation" do
  #     reservation20 = @coordinator01.make_reservation(Date.today + 8, Date.today + 13)
  #     room_id = reservation20.room_id
  #     room = @coordinator01.find_room(room_id)
  #     expect(@coordinator01.rm_available(room, @date_range)).must_equal false
  #     expect(room.bookings.length).must_equal 1
  #   end
  # end