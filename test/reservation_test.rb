require_relative 'test_helper'

describe "reservation" do
  start_date = Date.today
  end_date = start_date + 1 
  let(:reservation) { HotelBooking::Reservation.new(id: 3, start_date: start_date, end_date: end_date) }

  describe "initialization" do 
    it "creates a new instance of reservation" do 
      # id = 3
      # start_date = Date.today
      # end_date = start_date + 1  
      # HotelBooking::Reservation.new(id, start_date, end_date).must_be_instance_of HotelBooking::Reservation 
      reservation.must_be_instance_of HotelBooking::Reservation    
    end

    it "keeps track of id" do
      reservation.must_respond_to :id
      reservation.id.must_equal 3
    end

    it "keeps track of check-in date" do
      reservation.must_respond_to :start_date
      reservation.start_date.must_equal start_date
    end

    it "keeps track of check-out date" do
      reservation.must_respond_to :end_date
      reservation.end_date.must_equal end_date
    end
  end
end