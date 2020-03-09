require_relative "test_helper"

describe Hotel::Reservation do
  before do
    date_instance = Hotel::DateRange.new(
      start_date: Date.new(2021, 01, 01), 
      end_date: Date.new(2021, 01, 04)
    )

    @res_instance = Hotel::Reservation.new(
      date_range: date_instance,
      room: 2
    )
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@res_instance).must_be_kind_of Hotel::Reservation
    end
  end
 
  describe "cost" do
    it "returns a number" do
      expect(@res_instance.cost).must_be_kind_of Numeric
    end
  end
end
