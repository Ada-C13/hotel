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
end