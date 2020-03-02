require 'test_helper'

describe "Reservation class" do
  describe "initialize" do
    before do
      checkin = Date.new(2020, 1, 1)
      checkout = Date.new(2020, 1, 2)
      id = 1

      @reservation_data = {
        id: id,
        checkin: checkin,
        checkout: checkout,
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
      expect do
        Hotel::Reservation.new(id:0, checkin:checkin, checkout:checkout, room_id:2)
      end.must_raise ArgumentError.new("Bad ID for Reservation")
    end

    it "throws an argument error with a bad room_ID value" do
      expect do
        Hotel::Reservation.new(id:1, checkin:checkin, checkout:checkout, room_id:-1)
      end.must_raise ArgumentError.new("Invalid room_id")

      expect do
        Hotel::Reservation.new(id:1, checkin:checkin, checkout:checkout, room_id:21)
      end.must_raise ArgumentError.new("Invalid room_id")
    end

    it "throws an argument error if checkout date is before checkin date" do
      expect do
        Hotel::Reservation.new(id:1, checkin:checkout, checkout:checkin, room_id:2)
      end
    end
    
  end
end