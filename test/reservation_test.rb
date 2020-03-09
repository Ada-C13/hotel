require_relative "test_helper"

describe Hotel::Reservation do
  describe "consructor" do
    
    it "Creates an instance of reservation" do
      reservation = Hotel::Reservation.new(Date.today, Date.today + 1, Hotel::Room.new(1))
      reservation.must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of date_range" do
      start_date = Date.today
      end_date = Date.today + 1
      date_range = Hotel::DateRange.new(start_date, end_date)
  
      reservation = Hotel::Reservation.new(start_date, end_date, Hotel::Room.new(1))
      reservation.must_respond_to :date_range
      reservation.date_range.must_equal date_range
    end

  end
  
  describe "cost" do
    it "returns a number" do
      start_date = Date.today
      end_date = start_date + 3
      room = Hotel::Room.new(1, 200)

      @reservation = Hotel::Reservation.new(start_date, end_date, room)
      
      expect(@reservation.cost).must_be_kind_of Numeric
      expect(@reservation.cost).must_equal 600
    end
  end

end