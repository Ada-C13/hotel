require_relative "test_helper"
require 'date'


describe Hotel::Reservation do
  before do
    @room = Hotel::Room.new(1, 200)
    @start_date = Date.today
    @end_date = @start_date + 3
    @date_range = Hotel::DateRange.new(@start_date,@end_date)
    @reservation = Hotel::Reservation.new(1, @date_range,@room)   
  end
  describe "#initialize" do
    it 'Create an instance of reservation' do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it 'Keep track of reservation_id' do
      expect(@reservation.id).must_equal 1
    end 

    it "raise ArgumentError when id is not a positive integer" do
      expect{(Hotel::Reservation.new("kdjfkasdjfa",@date_range,@room))}.must_raise ArgumentError
    end
  end

  describe "cost" do
    it "returns a number" do
      expect(@reservation.room.cost).must_equal 200
      expect(@reservation.cost).must_be_kind_of Numeric
      expect(@reservation.cost).must_equal 600
    end
  end
end
