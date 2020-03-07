require_relative 'test_helper'

describe "Block class" do
  before do 
    @date_range = Hotel::DateRange.new(Date.new(2020, 05, 11), Date.new(2020, 05, 16))

    @rooms = []
    @reservations = []

    3.times do |i|
      room = Hotel::Room.new(id: i + 1)

      reservation = Hotel::Reservation.new(@date_range, room, is_block: true)

      @rooms << room 
      @reservations << reservation
    end 

   
    @block = Hotel::Block.new(@date_range, @rooms, @reservationn)
  end

  describe "#initialize" do 
    it "creates date_range, rooms and reservation" do
       
    end 
  end 
end 