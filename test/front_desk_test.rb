require_relative 'test_helper'

describe Hotel::FrontDesk do 
  # Intance of front_desk and date_range created before. Use them later to test.
  before do 
    @front_desk = Hotel::FrontDesk.new
    @date = Date.new(2020,05,21)
    start_date = @date
    end_date = start_date + 2
    @date_range = Hotel::DateRange.new(start_date,end_date)
  end

  describe "Wave number 1" do
    describe "room_list" do
      it "Returns a list of rooms" do
        rooms = @front_desk.room_list
        expect(rooms).must_be_kind_of Array
      end

      it "raises an error if the array of rooms it is empty" do
        rooms = @front_desk.room_list.length
        expect(rooms).must_be :>, 1
      end

      it "raises an error if there are not available rooms" do
        # 20 rooms created to test the case with not available dates.
        20.times do
          new_reservation = @front_desk.make_resevation(@date_range)
        end
        expect{ @front_desk.make_resevation(@date_range) }.must_raise ArgumentError
      end
    end

    describe "make_resevation" do
      it "Returns a new resevation" do
        new_reservation = @front_desk.make_resevation(@date_range)
        expect(new_reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "Reservations" do
      # New reservations created before to use in all cases of reservations.
      before do 
        @new_reservation = @front_desk.make_resevation(@date_range)
      end

      it "returns an array of reservations" do
        reservations = @front_desk.total_reservations
        # Every reservation within the array should be a instance of reservation.
        reservations.each do |reservation|
          reservation.must_be_kind_of Hotel::Reservation
        end
        expect(reservations).must_be_kind_of Array
      end

      it "returns an a array of reservations by date" do
        date = Date.new(2020,05,21)
        total_by_date = @front_desk.reservations_by_date(date)
        expect(total_by_date).must_be_kind_of Array
      end

      it "raises an error if there are not reservations by a specific date" do
        date = Date.new(2020,05,22)
        expect{ @front_desk.reservations_by_date(date) }.must_raise ArgumentError
      end

      it "returns a list of reservations for a specified room and a given date range" do
        search = @front_desk.reservations_by_room_date(1, @date_range)
        expect(search).must_be_kind_of Array
      end

      it "raises an error if there are not reservations for a specified room and a given date range" do
        expect{ @front_desk.reservations_by_room_date(3, @date_range) }.must_raise ArgumentError
      end

      it "returns the total cost for a given reservation" do
        reserv_id = @new_reservation.id
        cost = @front_desk.cost_by_reservation(reserv_id)
        expect(cost).must_be_close_to 400, 0.01
      end

    end
  end
end