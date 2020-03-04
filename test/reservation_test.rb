require_relative "test_helper"

describe "Reservation" do
  describe "Initialize" do
    it "Create an instance of Reservation" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "Room id tracker" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :id
      expect(reservation.id).must_equal 1
    end
    it "Keeps track of room" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :room
      expect(reservation.room).must_equal 3
    end

    it "Keeps track of the first day" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :start_date
      expect(reservation.start_date).must_equal Date.parse("March 3, 2020")
    end

    it "Keeps track of the last day" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :end_date
      expect(reservation.end_date).must_equal Date.parse("March 5, 2020")
    end
  end

  describe "total_cost" do
    it "Returns total cost for reservation" do
      room = Hotel::Room.new(3)
      reservation = Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation.total_cost).must_equal 400
    end
  end
end