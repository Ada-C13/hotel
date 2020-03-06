require_relative 'test_helper'
require 'date'


describe "HotelBlock class" do

  describe "Initializer" do
    before do
      date_in1 = DateTime.new(2020,2,3.5)
      date_out1 = DateTime.new(2020,2,5.5)
      date_in2 = DateTime.new(2020,2,7.5)
      date_out2 = DateTime.new(2020,2,14.5)
      date_in3 = DateTime.new(2020,2,14.5)
      date_out3 = DateTime.new(2020,2,16.5)
      @block = Hotel::HotelBlock.new(date_in: date_in1,date_out: date_out1 ,number_of_rooms: (2..5), rooms_block:[],discounted_room_rate: 150)
    #   @reservation1 = Hotel::Reservations.new(date_in:date_in1 , date_out:date_out1, room_id:1, room: @hotel.rooms[0])
    #   @reservation2 = Hotel::Reservations.new(date_in:date_in2 , date_out:date_out2, room_id:1, room: @hotel.rooms[0])
    #   @reservation3 = Hotel::Reservations.new(date_in:date_in3 , date_out:date_out3, room_id:1, room: @hotel.rooms[0])
    #   @hotel.rooms[0].add_a_reservation(@reservation1)
    #   @hotel.rooms[0].add_a_reservation(@reservation2)
    #   @hotel.rooms[0].add_a_reservation(@reservation3)
    end
    
    it "is an instance of FrontDesk" do
      # p @hotel
      expect(@block).must_be_kind_of Hotel::HotelBlock
    end
  end
end