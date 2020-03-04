# include Hotel
require_relative 'test_helper'

describe Hotel::Reservation do
  describe "initialize" do
    before do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2020, 1, 2)
      @date_range = Hotel::DateRange.new(start_date, end_date)
      room_id = 2
      @reservation = Hotel::Reservation.new(@date_range, room_id)
    end

    # add must_respond_to tests?
    #___________________________

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "throws an argument error if given an invalid room_ID value" do
      [-1, 0, 21, nil, true, "hello"].each do |num|
        expect do
          Hotel::Reservation.new(date_range:@date_range, room_id:num)
        end.must_raise ArgumentError
      end
    end

  end

  # describe "cost" do
  #   it "returns a number" do
  #     checkin = Date.new(2017, 01, 01)
  #     checkout = checkin + 3
  #     reservation = Reservation.new(id: 1, checkin:checkin, checkout:checkout, room_id:2)
  #     expect(reservation.cost).must_be_kind_of Numeric
  #   end
  # end

end