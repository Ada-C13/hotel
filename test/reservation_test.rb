require_relative "test_helper"

describe "Reservation" do
  before do
    date_range = Hotel::DateRange.new(Date.new(2020,5,3), Date.new(2020,5,5))

    @reservation = Hotel::Reservation.new(date_range, 1, 1, 200)
  end

  describe "initialize" do
    it "creates an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
      expect(@reservation).must_respond_to :date_range
      expect(@reservation).must_respond_to :nights
      expect(@reservation).must_respond_to :total_cost
      expect(@reservation).must_respond_to :id
      expect(@reservation).must_respond_to :room_number
    end

    it "determines total number of nights correctly" do
      expect(@reservation.nights).must_equal 2
    end

    it "can access start_date" do
      expect(@reservation.date_range.start_date).must_equal Date.new(2020,5,3)
    end

    it "can access end_date" do
      expect(@reservation.date_range.end_date).must_equal Date.new(2020,5,5)
    end

    it "can access the date_range range variable" do
      expect(@reservation.date_range.range).must_be_kind_of Array
    end

    it "creates correct number of elements within range" do
      expect(@reservation.date_range.range.length).must_equal 3
    end
  end

  describe "calculate_cost" do
    it "returns correct cost for a reservation" do
      cost = @reservation.calculate_cost()
      
      expect(cost).must_equal 400
    end
  end
end