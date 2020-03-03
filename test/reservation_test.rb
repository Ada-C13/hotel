require 'test_helper'
require 'date_range'

describe Hotel::Reservation do
  describe "initialize" do
    before do
      @id = 1
       # add new date_range here!!
      @date_range = date_range.new()

      @reservation_data = {
        id: @id,
        date_range: @date_range,
        room_id: 2,
        cost: 200,
      }
      @reservation = Hotel::Reservation.new(@reservation_data)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "throws an argument error with a bad ID value" do
      [-1, 0, 0.25].each do |num|
        expect do
          Hotel::Reservation.new(id:num, date_range:@date_range, room_id:2, cost:200)
        end.must_raise ArgumentError
      end
    end

    it "throws an argument error if given an invalid room_ID value" do
      [-1, 0, 21].each do |num|
        expect do
          Hotel::Reservation.new(id:1, date_range:@date_range, room_id:num, cost:200)
        end.must_raise ArgumentError
      end
    end

    it "throws an argument error if given an invalid cost" do
      [-1, 0].each do |num|
        expect do
          Hotel::Reservation.new(id:1, date_range:@date_range, room_id:num, cost:200)
        end.must_raise ArgumentError
      end
    end

  end

  describe "cost" do
    it "returns a number" do
      checkin = Date.new(2017, 01, 01)
      checkout = checkin + 3
      reservation = Hotel::Reservation.new(id: 1, checkin:checkin, checkout:checkout, room_id:2)
      expect(reservation.cost).must_be_kind_of Numeric
    end

  end
end