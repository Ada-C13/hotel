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
      @hotel = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms, blocks: [])
      @hotel.book_a_room(date_in1,date_out1,@hotel.rooms[0])
      @hotel.book_a_room(date_in2,date_out2,@hotel.rooms[0])
      @hotel.book_a_room(date_in3,date_out3,@hotel.rooms[0])
    end
    
    it "is an instance of FrontDesk" do
      expect(@hotel).must_be_kind_of Hotel::HotelManager
    end

    it"must return a list of all its rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
    end

    it "will raise an argument error if you try to book a room and room was unavailable" do
      date_in = DateTime.new(2020,2,14.5)
      date_out = DateTime.new(2020,2,16.5)
      expect{@hotel.book_a_room(date_in,date_out,@hotel.rooms[0])}.must_raise ArgumentError
    end

  end

  describe "rooms and reservations" do
    before do
      date_in1 = DateTime.new(2020,2,3.5)
      date_out1 = DateTime.new(2020,2,5.5)
      date_in2 = DateTime.new(2020,2,7.5)
      date_out2 = DateTime.new(2020,2,14.5)
      date_in3 = DateTime.new(2020,2,14.5)
      date_out3 = DateTime.new(2020,2,16.5)
      @hotel1 = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms, blocks: [])
      @hotel1.book_a_room(date_in1,date_out1,@hotel1.rooms[0])
      @hotel1.book_a_room(date_in2,date_out2,@hotel1.rooms[0])
      @hotel1.book_a_room(date_in3,date_out3,@hotel1.rooms[0])
    end

    it "raises an exception if you try to reserve an unavailable room" do
      @check_in = DateTime.new(2020,2,4.5)
      @check_out = DateTime.new(2020,3,4.5)
      expect{Hotel::Reservations.new(date_in: @check_in, date_out: @check_out , room_id:1, room: @hotel1.rooms[0])}.must_raise ArgumentError
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
      expect(@hotel1.rooms[0].list_of_reservations_for_data_range(start_date,end_date)).must_equal [@hotel1.rooms[0].reservations[0]]
      expect(@hotel1.rooms[0].list_of_reservations_for_data_range(start_date1,end_date1)).must_equal [@hotel1.rooms[0].reservations[0],@hotel1.rooms[0].reservations[1],@hotel1.rooms[0].reservations[2]]
      expect(@hotel1.rooms[0].list_of_reservations_for_data_range(start_date2,end_date2)).must_equal []
      expect(@hotel1.rooms[0].list_of_reservations_for_data_range(start_date3,end_date3)).must_equal [@hotel1.rooms[0].reservations[0]]
    end

    it "can return a list of all reservations on a specific date" do
      date = DateTime.new(2020,2,4.5)
      date1 = DateTime.new(2020,3,4.5)
      date2 = DateTime.new(2020,2,5.5)
      date3 = DateTime.new(2020,2,14.5)
      expect(@hotel1.list_reservations_on_specific_date(date)).must_equal  [@hotel1.rooms[0].reservations[0]]
      expect(@hotel1.list_reservations_on_specific_date(date1)).must_equal []
      expect(@hotel1.list_reservations_on_specific_date(date2)).must_equal []
      expect(@hotel1.list_reservations_on_specific_date(date3)).must_equal [@hotel1.rooms[0].reservations[2]]
    end

    it "can return a list of all available rooms on a specific date" do
      date = DateTime.new(2020,2,4.5)
      date1 = DateTime.new(2020,3,4.5)
      date2 = DateTime.new(2020,2,5.5)
      date3 = DateTime.new(2020,2,14.5)
      expect(@hotel1.list_available_rooms_on_specific_date(date)).must_equal @hotel1.rooms - [@hotel1.rooms[0]]
      expect(@hotel1.list_available_rooms_on_specific_date(date1)).must_equal @hotel1.rooms
      expect(@hotel1.list_available_rooms_on_specific_date(date2)).must_equal @hotel1.rooms
      expect(@hotel1.list_available_rooms_on_specific_date(date3)).must_equal @hotel1.rooms - [@hotel1.rooms[0]]
    end

    it "can return the total cost of a reservations" do
      expect(@hotel1.total_cost(@hotel1.rooms[0].reservations[0])).must_equal 400
      expect(@hotel1.total_cost(@hotel1.rooms[0].reservations[1])).must_equal 1400
      expect(@hotel1.total_cost(@hotel1.rooms[0].reservations[2])).must_equal 400
    end
  end

  describe "hotel block" do
    before do
      date_in1 = DateTime.new(2020,2,3.5)
      date_out1 = DateTime.new(2020,2,5.5)
      date_in2 = DateTime.new(2020,2,7.5)
      date_out2 = DateTime.new(2020,2,14.5)
      date_in3 = DateTime.new(2020,2,14.5)
      date_out3 = DateTime.new(2020,2,16.5)
      @hotel2 = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms, blocks: [])
      @hotel2.book_a_room(date_in1,date_out1,@hotel2.rooms[0])
      @hotel2.book_a_room(date_in2,date_out2,@hotel2.rooms[0])
      @hotel2.book_a_room(date_in3,date_out3,@hotel2.rooms[0])
      date_in4 = DateTime.new(2020,4,10.5)
      date_out4 = DateTime.new(2020,4,15.5)
      @block = @hotel2.book_a_block(date_in4,date_out4,4,150)
    end

    it "can add rooms to a hotel block" do
      expect(@block.rooms_block.length).must_equal 4
    end

    it "raises an Argument Error if there arent enough rooms to book a full block" do
      date_in = DateTime.new(2020,2,3.5)
      date_out = DateTime.new(2020,2,5.5)
      expect{@hotel2.book_a_block(date_in,date_out,19,150)}.must_raise ArgumentError
    end


    it "shows room is unavailable if you try to book a room within a block" do
      date_in = DateTime.new(2020,4,11.5)
      date_out = DateTime.new(2020,4,12.5)
      expect{@reservation = Hotel::Reservations.new(date_in:date_in , date_out:date_out, room_id:1, room: @hotel2.rooms[0])}.must_raise ArgumentError
    end 

    it "raises an argument error if you try to add room to a block with no room availability" do
      expect{@hotel2.add_rooms_to_block(@block,50)}.must_raise ArgumentError
    end 

  end  
end