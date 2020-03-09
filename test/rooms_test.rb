require_relative 'test_helper'

describe "rooms" do
  before do
    @room = Hotel::Room.new(room_number: 1, cost: 200)
  end

  describe "initializing room" do

    it "creates a Room object" do
      expect(@room).must_be_instance_of Hotel::Room
    end

    it "raises an arguement error if room number is less than 1 or more than 20" do
      expect{Hotel::Room.new(room_number: 21, cost: 200)}.must_raise ArgumentError
      expect{Hotel::Room.new(room_number: -1, cost: 200)}.must_raise ArgumentError
    end
  end

  describe "add_room_reservation" do
    # TODO write a let statement of new reservatio and room.add_res
    it "adds a reservation to a room object" do
      expect(@room.reservations.empty?).must_equal true

      @new_reservation = Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date: Date.today + 2, end_date: Date.today + 6), room: Hotel::Room.new(room_number: 1, cost: 200))
      @room.add_room_reservation(@new_reservation)
      expect(@room.reservations.count).must_equal 1
    end

    it "adds and reservation object to the collection of reservations in the room" do
      @new_reservation = Hotel::Reservation.new(date_range: Hotel::DateRange.new(start_date: Date.today + 2, end_date: Date.today + 6), room: Hotel::Room.new(room_number: 1, cost: 200))
      @room.add_room_reservation(@new_reservation)
      expect(@room.reservations.empty?).must_equal false
      expect(@room.reservations[0]).must_be_instance_of Hotel::Reservation
    end
  end

  describe "change_cost" do
    it "changes the discount cost rate" do
      expect(@room.discount_cost).must_equal 0
      
      discount_cost = 0.2
      @room.change_cost(discount_cost)
      expect(@room.discount_cost).must_equal discount_cost
    end
  end
end