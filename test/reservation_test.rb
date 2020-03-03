require_relative 'test_helper'

describe "reservation" do
  let(:start_date) { Date.today }
  let(:end_date) { start_date + 1 } 
  let(:reservation) { HotelBooking::Reservation.new(id: 3, start_date: start_date, end_date: end_date) }

  describe "initialization" do 
    it "creates a new instance of reservation" do 
      expect(reservation).must_be_instance_of HotelBooking::Reservation    
    end

    it "keeps track of id" do
      expect(reservation).must_respond_to :id
      expect(reservation.id).must_equal 3
    end

    it "requires a positive integer id" do
      expect { HotelBooking::Reservation.new(id: "not and integer", start_date: Date.today, end_date: (Date.today + 1))}.must_raise ArgumentError
      expect {HotelBooking::Reservation.new(id: -10, start_date: Date.today, end_date: (Date.today + 1))}.must_raise ArgumentError
    end

    it "keeps track of check-in date" do
      expect(reservation).must_respond_to :start_date
      expect(reservation.start_date).must_equal start_date
    end

    it "keeps track of check-out date" do
      expect(reservation).must_respond_to :end_date
      expect(reservation.end_date).must_equal end_date
    end
  end
end