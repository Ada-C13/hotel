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
end