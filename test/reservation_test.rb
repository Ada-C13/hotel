require_relative "test_helper"

describe Hotel::Reservation do
  describe "consructor" do
    
    it "Creates an instance of reservation" do
      reservation = Hotel::Reservation.new(1, Date.today, Date.today + 1, Hotel::Room.new(1))
      reservation.must_be_kind_of Hotel::Reservation
    end

    it "Keeps track of room id" do
      id = 1
      reservation = Hotel::Reservation.new(id, Date.today, Date.today + 1, Hotel::Room.new(1))
      reservation.must_respond_to :id
      reservation.id.must_equal id
    end

    it "Keeps track of date_range" do
      start_date = Date.today
      end_date = Date.today + 1
      date_range = Hotel::DateRange.new(start_date, end_date)
  
      reservation = Hotel::Reservation.new(1, start_date, end_date, Hotel::Room.new(1))
      reservation.must_respond_to :date_range
      reservation.date_range.must_equal date_range
    end

  end




  # describe "cost" do
  #   it "returns a number" do
  #     start_date = Date.new(2017, 01, 01)
  #     end_date = start_date + 3
  #     reservation = Hotel::Reservation.new(start_date, end_date, nil)
  #     expect(reservation.cost).must_be_kind_of Numeric
  #   end
  # end
end