require_relative 'test_helper'
require_relative '../lib/date_range'

describe "front desk" do
  before do
    @front_desk = Hotel::FrontDesk.new
  end

  describe "self.rooms" do
  
    it "stores all 20 hotel rooms" do
      expect(@front_desk.rooms.count).must_equal 20
    end

    it "returns an array of the 20 rooms" do
      expect(@front_desk.rooms).must_be_instance_of Array
    end

    it "stores instances of the Room class inside the array" do
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
    end
  end

  describe "find_room" do
    before do
      @front_desk = Hotel::FrontDesk.new
    end

    it "finds an instance of a room given the room number" do
      room_number = 4
      expect(@front_desk.find_room(room_number)).must_be_instance_of Hotel::Room
    end
  end

  # describe "add_reservation" do
  #   before do
  #     @dates = Hotel::DateRange.new(start_date: "3/4/2020", end_date: "3/7/2020")
  #     @front_desk.add_reservation(@dates)
  #   end
    
  #   it "adds an id to the reservation" do
  #     expect(@front_desk.reservations[0].id).must_be_instance_of Integer
  #   end

  #   it "adds a an instance of the room class to the reservation" do
  #     expect(@front_desk.reservations[0].room).must_be_instance_of Hotel::Room
  #   end
  # end

  # describe "find_reservation_with(date_range)" do
  #   before do
  #     @dates = Hotel::DateRange.new(start_date: "3/4/2020", end_date: "3/7/2020")
  #   end

  #   it "returns an array of reservations that match the date" do
  #     expect(@front_desk.find_reservation_with(@date)).must_be_instance_of Array
  #     expect(@front_desk.find_reservation_with(@date).sample).must_be_instance_of (Hotel::Reservation || nil) 
  #     #make a test where one array will be empty so I can check nil, and another where it will have a reservation
  #   end

  # end
end