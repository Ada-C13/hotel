require 'date'
require_relative "test_helper"

xdescribe "Reservation class" do
  describe "Initializer" do
    let(:start_date) { Date.new(2001, 2, 3) }
    let(:end_date) { Date.new(2001, 2, 6) }
    it "is an instance of Reservation" do
      res = Reservation.new(Room.new(1), start_date, end_date)
      expect(res).must_be_kind_of Reservation
    end
    it "Calculates Total of Reservation" do
      res = Reservation.new(Room.new(1),start_date, end_date)
      expect(res.number_of_nights?).must_equal 2
    end
    it "takes in the date" do
      res = Reservation.new(Room.new(1),
      start_date, end_date)
      expect(res.total).must_equal 400
    end
  end
end
