require_relative "test_helper"

describe "Reservation" do
  # Arrange
  describe "initialize" do
    #Act
    it "Create an instance of Reservation" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
    #Act
    it "Room id tracker" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :id
      expect(reservation.id).must_equal 1
    end
    # Act
    it "Keeps track of room" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :room
      expect(reservation.room).must_equal 3
    end
    # Act
    it "Keeps track of the first day" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :start_date
      expect(reservation.start_date).must_equal Date.parse("March 3, 2020")
    end
    # Act
    it "Keeps track of the last day" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_respond_to :end_date
      expect(reservation.end_date).must_equal Date.parse("March 5, 2020")
    end
    # Act
    it "Throws error if end date is before start date" do
      start_date = "March 5, 2020"
      end_date = "March 3, 2020"
      # Assert
      expect{ Hotel::Reservation.new(1, 3, start_date, end_date) }.must_raise ArgumentError
    end
    # Act
    it "Keep track of discount" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020", 0.50)
      # Assert
      expect(reservation).must_respond_to :discount
      expect(reservation.discount).must_equal 0.50
    end
    # Act
    it "Set discount to a default of nil" do
      reservation = Hotel::Reservation.new(1, 3, "March 3, 2020", "March 5, 2020")
      assert_nil(reservation.discount)
    end
  end
  # Arrange
  describe "total_cost" do
    # Act
    it "Returns total cost for reservation" do
      room = Hotel::Room.new(3)
      reservation = Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation.total_cost).must_equal 400
    end
    # Act
    it "Returns total_cost with discount if processed" do
      room = Hotel::Room.new(3)
      reservation = Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020", 50)
      reservation = Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020", 0.50)
      # Assert
      expect(reservation.total_cost).must_equal 200
    end
  end
end