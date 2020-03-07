require_relative 'test_helper'

describe "reservation" do
  let(:date_range) { HotelBooking::DateRange.new(start_date: Date.today, end_date: (Date.today + 3)) }
  let(:room) { HotelBooking::Room.new(number: 1) }
  let(:reservation) { HotelBooking::Reservation.new(date_range: date_range, room: room) }

  let(:start_date) { Date.new(2020, 3, 23)}
  let(:end_date) { Date.new(2020, 3, 27)}
  let(:date_range_b) { HotelBooking::DateRange.new(start_date: start_date, end_date: end_date) }
  let(:room_b) { HotelBooking::Room.new(number: 2, in_block: true) } 
  let(:block_b) { HotelBooking::HotelBlock.new(name: "me", date_range: date_range_b, room_count: 1 , discount_rate: 0.9)}
  let(:reservation_b) {HotelBooking::Reservation.new(date_range: date_range_b, room: room_b, block: block_b)}

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
    it "for a regular reservation each night's cost is 200" do
      expect(reservation.cost).must_be_kind_of Numeric
      expect(reservation.cost).must_equal 600
    end

    it "for a block reservation, takes the discount rate into consideration" do
      expect(reservation_b.cost).must_equal 720
    end
  end

end

   


