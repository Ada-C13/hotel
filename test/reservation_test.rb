require_relative "test_helper"

describe Hotel::Reservation do
  describe "cost" do
    it "returns a number" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      reservation = Reservation.new(start_date, end_date,1)
      expect(reservation.cost(start_date, end_date)).must_be_kind_of Numeric
      expect(reservation.cost(start_date, end_date)).must_be_kind_of Integer
    end

    it "returns a the correct cost" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date + 3
      reservation = Reservation.new(start_date, end_date,1)
      expect(reservation.cost(start_date, end_date)).must_equal 400
   
    end

    it "returns a error when end_date < start_date" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date - 3
      expect{Reservation.new(start_date, end_date,1)}.must_raise ArgumentError
   
    end

    it "returns a error when @end_date && (@end_date == @start_date)" do
      start_date = Date.new(2017, 01, 01)
      end_date = start_date 
      expect{Reservation.new(start_date, end_date,1)}.must_raise ArgumentError
   
    end

  end
end