require_relative 'test_helper'
require 'date'


describe "HotelManager class" do

  describe "Initializer" do
    before do
      date_in1 = DateTime.new(2020,2,3.5)
      date_out1 = DateTime.new(2020,2,5.5)
      date_in2 = DateTime.new(2020,2,7.5)
      date_out2 = DateTime.new(2020,2,14.5)
      date_in3 = DateTime.new(2020,2,14.5)
      date_out3 = DateTime.new(2020,2,16.5)
      @hotel = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms)
      @reservation1 = Hotel::Reservations.new(date_in:date_in1 , date_out:date_out1, room_id:1, room: @hotel.rooms[0])
      @reservation2 = Hotel::Reservations.new(date_in:date_in2 , date_out:date_out2, room_id:1, room: @hotel.rooms[0])
      @reservation3 = Hotel::Reservations.new(date_in:date_in3 , date_out:date_out3, room_id:1, room: @hotel.rooms[0])
      @hotel.rooms[0].add_a_reservation(@reservation1)
      @hotel.rooms[0].add_a_reservation(@reservation2)
      @hotel.rooms[0].add_a_reservation(@reservation3)
    end
    
    it "is an instance of FrontDesk" do
      # p @hotel
      expect(@hotel).must_be_kind_of Hotel::HotelManager
    end

    it"must return a list of all its rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
    end

    it "raises an exception if you try to reserve an unavailable room" do
      @check_in = DateTime.new(2020,2,4.5)
      @check_out = DateTime.new(2020,3,4.5)
      expect{Hotel::Reservations.new(date_in: @check_in, date_out: @check_out , room_id:1, room: @hotel.rooms[0])}.must_raise ArgumentError
  end

    it "can return a list of reservations for a room on a certain date" do
    start_date= DateTime.new(2020,1,3.5)
    end_date = DateTime.new(2020,2,4.5)
    start_date1= DateTime.new(2020,2,4.5)
    end_date1 = DateTime.new(2020,2,29.5)
    start_date2= DateTime.new(2020,1,3.5)
    end_date2 = DateTime.new(2020,1,4.5)
    start_date3= DateTime.new(2020,2,3.5)
    end_date3 = DateTime.new(2020,2,4.5)
    # puts @hotel.rooms[0].list_of_reservations_for_data_range(start_date,end_date)
    # puts @hotel.rooms[0].list_of_reservations_for_data_range(start_date1,end_date1)
    # puts @hotel.rooms[0].list_of_reservations_for_data_range(start_date2,end_date2)
    expect(@hotel.rooms[0].list_of_reservations_for_data_range(start_date,end_date)).must_equal [@reservation1]
    expect(@hotel.rooms[0].list_of_reservations_for_data_range(start_date1,end_date1)).must_equal [@reservation1,@reservation2,@reservation3]
    expect(@hotel.rooms[0].list_of_reservations_for_data_range(start_date2,end_date2)).must_equal []
    expect(@hotel.rooms[0].list_of_reservations_for_data_range(start_date3,end_date3)).must_equal [@reservation1]
    end

    it "can return a list of all reservations on a specific date" do
      date = DateTime.new(2020,2,4.5)
      date1 = DateTime.new(2020,3,4.5)
      date2 = DateTime.new(2020,2,5.5)
      date3 = DateTime.new(2020,2,14.5)
      expect(@hotel.list_reservations_on_specific_date(date)).must_equal  [[@reservation1]]
      expect(@hotel.list_reservations_on_specific_date(date1)).must_equal []
      expect(@hotel.list_reservations_on_specific_date(date2)).must_equal []
      expect(@hotel.list_reservations_on_specific_date(date3)).must_equal [[@reservation3]]
    end

    it "can return a list of all available rooms on a specific date" do
      date = DateTime.new(2020,2,4.5)
      date1 = DateTime.new(2020,3,4.5)
      date2 = DateTime.new(2020,2,5.5)
      date3 = DateTime.new(2020,2,14.5)
      expect(@hotel.list_available_rooms_on_specific_date(date)).must_equal @hotel.rooms - [@hotel.rooms[0]]
      expect(@hotel.list_available_rooms_on_specific_date(date1)).must_equal @hotel.rooms
      expect(@hotel.list_available_rooms_on_specific_date(date2)).must_equal @hotel.rooms
      expect(@hotel.list_available_rooms_on_specific_date(date3)).must_equal @hotel.rooms - [@hotel.rooms[0]]
    end

    it "can return the total cost of a reservations" do
    expect(@hotel.total_cost(@reservation1)).must_equal 400
    expect(@hotel.total_cost(@reservation2)).must_equal 1400
    expect(@hotel.total_cost(@reservation3)).must_equal 400
    end

  end  
end