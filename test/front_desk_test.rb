require_relative 'test_helper'

describe Hotel::FrontDesk do 
  before do 
    @front_desk = Hotel::FrontDesk.new
    @date = Date.new(2020,05,21)
    start_date = @date
    end_date = start_date + 2
    @datarange = Hotel::DateRange.new(start_date,end_date)
  end

  describe "Wave number 1" do
    describe "room_list" do
      it "Returns a list of rooms" do
        rooms = @front_desk.room_list
        expect(rooms).must_be_kind_of Array
      end
      it "Raises an error if the array of rooms it is empty" do
        rooms = @front_desk.room_list.length
        expect(rooms).must_be :>, 1
      end
    end
    # Desribed 
    describe "make_resevation" do
      it "Returns a new resevation" do
        new_reservation = @front_desk.make_resevation(@datarange)
        expect(new_reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "Reservations" do
      it "returns an array of reservations" do
        reservations = @front_desk.reservations
        expect(reservations).must_be_kind_of Array
        reservations.each do |reservation|
          reservation.must_be_kind_of Reservation
        end
      end
    end

    describe "Reservations_by_date" do
      it "returns an a array of reservations by date" do
        date = Date.new(2017,12,04)
        total_by_date = @front_desk.reservations_by_date(date)
        expect(total_by_date).must_be_kind_of Array
      end
    end

    describe "Cost_by_reservation" do
      it "returns the total cost for a given reservation" do
        new_reservation = @front_desk.make_resevation(@datarange)
        reserv_id = new_reservation.id
        cost = @front_desk.cost_by_reservation(reserv_id)
        expect(cost).must_be_close_to 400, 0.01
      end
    end


  end



end
