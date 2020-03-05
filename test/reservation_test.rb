require_relative 'test_helper'

describe "reservation" do
  let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }
  let (:room) { HotelBooking::Room.new(number: 1) } 
  let(:reservation) { HotelBooking::Reservation.new(date_range: date_range, room: room) }

  describe "initialization" do 
    it "creates a new instance of reservation" do 
      expect(reservation).must_be_instance_of HotelBooking::Reservation    
    end

    it "keeps track of date range" do
      expect(reservation).must_respond_to :date_range
    end

    it "date range is an instance of DateRange" do
      expect(reservation.date_range).must_be_instance_of HotelBooking::DateRange  
    end

    it "keeps track of reserved room" do
      expect(reservation).must_respond_to :room
    end

    it "room is an instane ot Room class" do
      expect(reservation.room).must_be_instance_of HotelBooking::Room
    end

  end

  describe "cost" do
    it "returns a number" do
      expect(reservation.cost).must_be_kind_of Numeric
      expect(reservation.cost).must_equal 600
    end
  end

end


# make this test be for making a new reservation instead of a date range

   


