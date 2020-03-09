require_relative "test_helper"

describe "Reservation" do
  let (:room) { Hotel::Room.new(3) }
  let (:reservation) { Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020")}
  # Arrange
  describe "initialize" do
    #Act
    it "Create an instance of Reservation" do
      # Assert
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
    #Act
    it "Room id tracker" do
      # Assert
      expect(reservation).must_respond_to :id
      expect(reservation.id).must_equal 1
    end
    # Act
    it "Keeps track of room" do
      # Assert
      expect(reservation).must_respond_to :room
      expect(reservation.room).must_equal room
    end
    # Act
    it "Keeps track of the first day" do
      # Assert
      expect(reservation).must_respond_to :start_date
      expect(reservation.start_date).must_equal Date.parse("March 3, 2020")
    end
    # Act
    it "Keeps track of the last day" do
      # Assert
      expect(reservation).must_respond_to :end_date
      expect(reservation.end_date).must_equal Date.parse("March 5, 2020")
    end
    # Act
    it "Throws error if end date is before start date" do
      start_date = "March 5, 2020"
      end_date = "March 3, 2020"
      # Assert
      expect{ Hotel::Reservation.new(1, room, start_date, end_date) }.must_raise StandardError
    end
    # Act
    it "Discount tracker" do
      reservation = Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020", 0.50, :CONFIRMED)
      # Assert
      expect(reservation).must_respond_to :discount
      expect(reservation.discount).must_equal 0.50
    end
    # Act
    it "Set discount to a default of nil" do
      # Assert
      assert_nil(reservation.discount)
    end
    # Act
    it "Status tracker" do
      # Assert
      expect(reservation).must_respond_to :status
    end
    # Act
    it "Status default set to 'confirmed' " do
      # Assert
      expect(reservation.status).must_equal :CONFIRMED
    end
  end

  # Arrange
  describe "total_cost" do
    # Act
    it "Returns total cost for reservation" do
      room = Hotel::Room.new(3)
      # Assert
      expect(reservation.total_cost).must_equal 400
    end
    # Act
    it "Returns total_cost with discount if processed" do
      room = Hotel::Room.new(3)
      reservation = Hotel::Reservation.new(1, room, "March 3, 2020", "March 5, 2020", 0.50, :CONFIRMED)
      # Assert
      expect(reservation.total_cost).must_equal 200
    end
  end
end