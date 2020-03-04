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

    it "stores an instance variable @reservations that is an array" do
      expect(@room01.bookings).must_be_instance_of Array
    end

    # it "stores an @reservations array where each element is a Reservation instance " do
    #   expect(@room01.bookings[0]).must_be_instance_of Hotel::Reservation
    # end
  
  end

  describe "#add_booking_to_room" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      room_id = 10
      @reservation01 = Hotel::Reservation.new(date_range, room_id)
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

  # describe "self.all" do
  #   it "returns an array of all the rooms" do
      
  #   end
  # end

  # describe "self.find(id)" do
  #   it "returns the room instance via room_id" do
      
  #   end
  # end
end