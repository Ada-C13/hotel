require 'test_helper.rb'


describe "Reservation class" do
  describe "Reservation instantiation" do
    before do
      @reservation = Reservation.new(id: 1, room: 2, start_date: Date.new(1993, 2, 24), end_date: Date.new(1993, 2, 28))
    end
    it "is an instance of reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end
  end
end