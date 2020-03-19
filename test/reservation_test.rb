require_relative "test_helper"

describe Hotel::Reservation do
  describe "constructor" do
    start_date = Date.new(2017, 01, 01)
    end_date = start_date + 3
    reservation = Hotel::Reservation.new(start_date, end_date, nil)
    describe "cost" do
      it "returns a number" do
        expect(reservation.cost).must_be_kind_of Numeric
      end
      it "returns correct number" do
        expect(reservation.cost).must_equal 600
      end
    end

    describe "nights" do 
      it "returns a number" do
        expect(reservation.num_nights).must_be_kind_of Numeric
      end
      it "returns correct number" do
        expect(reservation.num_nights).must_equal 3
      end
    end
  end
end
