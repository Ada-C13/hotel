require_relative 'test_helper'

describe "Receptionist class" do

  describe "Initializer" do
    before do
        date_in1 = DateTime.new(2020,2,3.5)
        date_out1 = DateTime.new(2020,2,5.5)
        date_in2 = DateTime.new(2020,2,7.5)
        date_out2 = DateTime.new(2020,2,14.5)
        date_in3 = DateTime.new(2020,2,14.5)
        date_out3 = DateTime.new(2020,2,16.5)
        @hotel = Hotel::HotelManager.new(rooms: Hotel::Room.list_of_rooms,blocks: [])
        @reservation1 = Hotel::Reservations.new(date_in:date_in1 , date_out:date_out1, room_id:1, room: @hotel.rooms[0])
        @reservation2 = Hotel::Reservations.new(date_in:date_in2 , date_out:date_out2, room_id:1, room: @hotel.rooms[0])
        @reservation3 = Hotel::Reservations.new(date_in:date_in3 , date_out:date_out3, room_id:1, room: @hotel.rooms[0])
        @hotel.add_a_reservation_to_room(@hotel.rooms[0],@reservation1)
        @hotel.add_a_reservation_to_room(@hotel.rooms[0],@reservation2)
        @hotel.add_a_reservation_to_room(@hotel.rooms[0],@reservation3)
        @room = Hotel::Room.new(id: 34, reservations: [])
      end
      
    it "is an instance of room" do
        expect(@room).must_be_kind_of Hotel::Room
    end

    it "returns the right id" do
        expect(@room.id).must_equal 34
    end

    it "returns the right reservations" do
        expect(@room.reservations).must_equal []
    end

    it "can return a list of rooms" do
        rooms = Hotel::Room.list_of_rooms
        expect(rooms[0].id).must_equal 1
        expect(rooms[0].reservations).must_be_kind_of Array
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

    it "can return an reservation in a room on a specific date" do
        date = DateTime.new(2020,2,4.5)
        date1 = DateTime.new(2020,3,4.5)
        date2 = DateTime.new(2020,2,5.5)
        date3 = DateTime.new(2020,2,14.5)
        expect(@hotel.rooms[0].specific_date_reservations(date)).must_equal [@reservation1]
        expect(@hotel.rooms[0].specific_date_reservations(date1)).must_equal []
        expect(@hotel.rooms[0].specific_date_reservations(date2)).must_equal []
        expect(@hotel.rooms[0].specific_date_reservations(date3)).must_equal [@reservation3]
    end

    it "returns false when a room is anavailable" do
        date = DateTime.new(2020,2,4.5)
        date1 = DateTime.new(2020,3,4.5)
        date2 = DateTime.new(2020,2,5.5)
        date3 = DateTime.new(2020,2,14.5)
        expect(@hotel.rooms[0].specific_date_availability(date)).must_equal [false]
        expect(@hotel.rooms[0].specific_date_availability(date1)).must_equal []
        expect(@hotel.rooms[0].specific_date_availability(date2)).must_equal []
        expect(@hotel.rooms[0].specific_date_availability(date3)).must_equal [false]
    end

    it "returns unavailable when a room is anavailable within a date range" do
        date_in = DateTime.new(2020,2,4.5)
        date_out = DateTime.new(2020,2,5.5)
        date_in1 = DateTime.new(2020,3,4.5)
        date_out1 = DateTime.new(2020,3,5.5)
        date_in2 = DateTime.new(2020,2,5.5)
        date_out2 = DateTime.new(2020,2,6.5)
        date_in3 = DateTime.new(2020,2,14.5)
        date_out3 = DateTime.new(2020,2,15.5)
        expect(@hotel.rooms[0].daterange_availability(date_in,date_out)).must_equal :UNAVAILABLE
        expect(@hotel.rooms[0].daterange_availability(date_in1,date_out1)).must_equal :AVAILABLE
        expect(@hotel.rooms[0].daterange_availability(date_in2,date_out2)).must_equal :AVAILABLE
        expect(@hotel.rooms[0].daterange_availability(date_in3,date_out3)).must_equal :UNAVAILABLE
    end

    it "checks whether a desired check in range overlaps with a given room's reservations" do
        start_date= DateTime.new(2020,2,1.5)
        end_date = DateTime.new(2020,2,4.5)
        start_date1= DateTime.new(2020,3,3.5)
        end_date1 = DateTime.new(2020,3,4.5)
        expect(@hotel.rooms[0].test_overlap(start_date,end_date)).must_equal true
        expect(@hotel.rooms[0].test_overlap(start_date1,end_date1)).must_equal false
    end
  end  
end