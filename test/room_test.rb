require_relative 'test_helper'

describe Hotel::Room do
  before do
    @room_id = 10
    @room01 = Hotel::Room.new(@room_id)
  end

  describe "#initialize" do
    it "is an instance of Room" do
      expect(@room01).must_be_instance_of Hotel::Room
    end

    it "stores a room_id as id" do
      expect(@room01.room_id).must_equal @room_id
    end

    it "raises ArgumentError if the room_id is not a positive integer" do
      expect{Hotel::Room.new(-10)}.must_raise ArgumentError
      expect{Hotel::Room.new("suite")}.must_raise ArgumentError
    end

    it "stores a cost for the room instance" do
      expect(@room01.cost).must_be_instance_of Float
      expect(@room01.cost).must_equal 200.00
    end
  end

  describe "@bookings" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
      @room01.add_booking_to_room(@reservation01)
    end

    it "stores an instance variable @bookings that is an array" do
      expect(@room01.bookings).must_be_instance_of Array
    end

    it "stores each element as a Reservation instance " do
      @room01.bookings.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end
  end

  describe "#add_booking_to_room" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
    end

    it "returns an array of all the current bookings" do
      expect(@room01.add_booking_to_room(@reservation01)).must_be_instance_of Array
    end

    it "includes the new booking into @bookings" do
      expect(@room01.add_booking_to_room(@reservation01)).must_include @reservation01
    end

    it "increases @bookings size by 1" do
      before_size = @room01.bookings.length
      after_size = (@room01.add_booking_to_room(@reservation01)).length
      expect(after_size).must_equal before_size + 1
    end
  end

  describe "#get_price" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
      @room01.add_booking_to_room(@reservation01)
    end

    it "returns a Float for the reservation" do
      expect(@room01.get_price(@reservation01)).must_be_instance_of Float
    end

    it "returns the total price for the reservation" do
      expect(@room01.get_price(@reservation01)).must_equal 1000.00
    end
  end

  describe "#is_available" do
    before do
      @coordinator01 = Hotel::SystemCoordinator.new
      @start_date = Date.today + 5
      @end_date = Date.today + 10
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "returns true if room is available with no reservations" do
      expect(@room01.is_available(@date_range)).must_equal true
      expect(@room01.bookings.length).must_equal 0
    end

    it "returns true if room is available with exact block match" do
      block10 = Hotel::Block.new(@date_range, @room_id)
      @room01.add_booking_to_room(block10)
      expect(@room01.is_available(@date_range)).must_equal true
      expect(@room01.bookings.length).must_equal 1
    end

    it "returns true if room is available with no overlapping reservations" do
      range20 = Hotel::DateRange.new(Date.today + 10, Date.today + 12) 
      reservation01 = Hotel::Reservation.new(range20, @room_id)
      @room01.add_booking_to_room(reservation01)
      expect(@room01.is_available(@date_range)).must_equal true
      expect(@room01.bookings.length).must_equal 1
    end

    it "returns false when room has overlapping block" do
      range20 = Hotel::DateRange.new(Date.today + 5, Date.today + 11) 
      block20 = Hotel::Block.new(range20, @room_id)
      @room01.add_booking_to_room(block20)
      expect(@room01.is_available(@date_range)).must_equal false
      expect(@room01.bookings.length).must_equal 1
    end

    it "returns false when room has overlapping reservation" do
      range30 = Hotel::DateRange.new(Date.today + 5, Date.today + 6) 
      reservation01 = Hotel::Reservation.new(range30, @room_id)
      @room01.add_booking_to_room(reservation01)
      expect(@room01.is_available(@date_range)).must_equal false
      expect(@room01.bookings.length).must_equal 1
    end
  end

  describe "#change_rate" do
    it "returns a float of the new rate" do
      expect(@room01.change_rate(100)).must_be_instance_of Float
      expect(@room01.change_rate(100)).must_equal 100.00
    end

    it "changes the room the correct new rate" do
      expect(@room01.cost).must_equal 200.00
      new_rate = 100
      @room01.change_rate(new_rate)
      expect(@room01.cost).must_equal new_rate
    end

    it "raises an exception if the new rate is < 0" do
      expect{@room01.change_rate(-99)}.must_raise ArgumentError
      expect{@room01.change_rate("free")}.must_raise ArgumentError
    end
  end
end
