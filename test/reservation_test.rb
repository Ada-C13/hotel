require 'test_helper'

describe Hotel::Reservation do
  describe "initialize" do
    before do
      @checkin = Date.new(2020, 1, 1)
      @checkout = Date.new(2020, 1, 2)
      @id = 1

      @reservation_data = {
        id: @id,
        checkin: @checkin,
        checkout: @checkout,
        room_id: 2,
        # when reserved, the status is unavailable. Also could think about an in-progress value for reservation?
        # status: unavailable,
      }
      @reservation = Hotel::Reservation.new(@reservation_data)
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "throws an argument error with a bad ID value" do
      [-1, 0, 0.25].each do |num|
        expect do
          Hotel::Reservation.new(id:num, checkin:@checkin, checkout:@checkout, room_id:2)
        end.must_raise ArgumentError
      end
    end

    it "throws an argument error if given an invalid room_ID value" do
      [-1, 0, 21].each do |num|
        expect do
          Hotel::Reservation.new(id:1, checkin:@checkin, checkout:@checkout, room_id:num)
        end.must_raise ArgumentError
      end
    end

    it "throws an argument error if checkout date is before checkin date" do
      expect do
        Hotel::Reservation.new(id:1, checkin:@checkout, checkout:@checkin, room_id:2)
      end.must_raise ArgumentError
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