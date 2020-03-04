require_relative 'test_helper'

describe Hotel::SystemCoordinator do
  before do
    @coordinator01 = Hotel::SystemCoordinator.new
  end

  describe "@rooms" do
    it "is an instance variable @rooms that is an array" do
      expect(@coordinator01.rooms).must_be_instance_of Array
    end

    it "stores each element in the @rooms array as an instance of Room" do
      @coordinator01.rooms.each do |room|
        expect(room).must_be_instance_of Hotel::Room
      end
    end

    it "stores the correct room ids from 1 ~20" do
      @coordinator01.rooms.each_with_index do |room,i|
        expect(room.id).must_equal (i+1)
      end
    end

    it "stores the correct cost $200 in each room instance" do
      @coordinator01.rooms.each do |room|
        expect(room.cost).must_be_instance_of Float
        expect(room.cost).must_equal 200.00
      end
    end
  end

  describe "@reservations" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @room_id = 10
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
      @coordinator01.reservations << @reservation01
    end
    # let (:reservation01) {
    #   Hotel::Reservation.new(Hotel::DateRange.new(Date.today + 5, Date.today + 10), 10)
    # }

    it "returns an array of reservations that include that date" do
      expect(@coordinator01.reservations).must_be_instance_of Array
    end

    it "stores Reservation instances in each element of @reservations" do
      @coordinator01.reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
        expect(reservation.date_range).must_be_instance_of Hotel::DateRange
        expect(reservation.room_id).must_equal @room_id
      end
    end

    it "stores the correct room_id in each of the Reservation instances" do
      expect(@coordinator01.reservations[0].room_id).must_equal @room_id
    end
  end

  describe "#find_reservation_by_date" do
    before do
      date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
      @room_id = 10
      @reservation01 = Hotel::Reservation.new(date_range, @room_id)
      @coordinator01.reservations << @reservation01

      @found_reservations = @coordinator01.find_reservation_by_date(Date.today + 7)
    end

    it "returns an array" do
      expect(@found_reservations).must_be_instance_of Array
      # expect(@coordinator01.find_reservation_by_date(date10)).must_be_instance_of Array
    end

    it "returns what? when the date is not included" do
      date11 = Date.today + 1
      expect(@coordinator01.find_reservation_by_date(date11)).must_equal []
    end

    it "stores Reservation instances in the returned array" do
      @found_reservations.each do |reservation|
        expect(reservation).must_be_instance_of Hotel::Reservation
      end
    end

  end
end