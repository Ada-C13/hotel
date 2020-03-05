require_relative "test_helper"

describe "ReservationManager" do
  describe "Initialize" do
    it "Create an instance of BookingManager" do
      manager = Hotel::ReservationManager.new
      # Assert
      expect(manager).must_be_kind_of Hotel::ReservationManager
    end

    it "Respond to all_rooms" do
      manager = Hotel::ReservationManager.new
      # Assert
      expect(manager).must_respond_to :all_rooms
      expect(manager.all_rooms).must_be_kind_of Array
      expect(manager.all_rooms.length).must_equal 20
    end

    it "Respond to reservations" do
      manager = Hotel::ReservationManager.new
      # Assert
      expect(manager).must_respond_to :all_reservations
      expect(manager.all_reservations).must_be_kind_of Array
      expect(manager.all_reservations).must_equal []
    end  
  end

  describe "available_rooms method" do
    it "When no rooms have been booked return 20 available rooms" do
      manager = Hotel::ReservationManager.new
      rooms = manager.available_rooms("March 3, 2020", "March 5, 2020")
      # Assert
      expect(rooms.length).must_equal 20
    end

    it "When one room has been booked return 19 available rooms" do
      manager = Hotel::ReservationManager.new
      manager.make_reservation("March 3, 2020", "March 5, 2020")
      rooms = manager.available_rooms("March 3, 2020", "March 5, 2020")
      # Assert
      expect(rooms.length).must_equal 19
    end    
  end

  describe "make_reservation" do
    it "Creates a new reservation" do
      manager = Hotel::ReservationManager.new
      reservation = manager.make_reservation("March 3, 2020", "March 5, 2020")
      # Assert
      expect(reservation).must_be_kind_of Hotel::Reservation
    end
  end

  describe "find_reservation" do
    it "Finds reservations for a specific date" do
      manager = Hotel::ReservationManager.new
      manager.make_reservation("March 1, 2020", "March 3, 2020") 
      manager.make_reservation("March 1, 2020", "March 8, 2020")
      manager.make_reservation("March 3, 2020", "March 6, 2020") 
      manager.make_reservation("March 3, 2020", "March 5, 2020")
      manager.make_reservation("March 15, 2020", "March 18, 2020")

      date = "March 3, 2020"
      specific_reservation = manager.find_reservation(date)
      # Assert
      expect(specific_reservation).must_be_kind_of Array
      expect(specific_reservation.length).must_equal 3

      specific_reservation.each do |reservation|
        _(reservation).must_be_kind_of Hotel::Reservation
        #_(reservation.start_date).must_equal Date.parse(date)
      end
    end  
  end
end