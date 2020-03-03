require_relative 'test_helper'

describe Hotel::FrontDesk do 
  before do 
    @front_desk = Hotel::FrontDesk.new
    @date = Date.parse("2020-05-21")
    start_date = @date
    end_date = start_date + 2
    @datarange = Hotel::DateRange.new(start_date,end_date)
  end

  describe "*** Wave number 1 ***" do
    describe "room_list" do
      it "==== Returns a list of rooms ==== " do
        rooms = @front_desk.room_list
        expect(rooms).must_be_kind_of Array
      end
      it "=== raise an error if the array of rooms it is empty ===" do
        rooms = @front_desk.room_list.length
        expect(rooms).must_be :>, 1
      end
    end
    
    describe "make_resevation" do
      it "=== Returns a new resevation ===" do
        new_reservation = @front_desk.make_resevation(@datarange,nil)
        expect(new_reservation).must_be_kind_of Hotel::Reservation
      end
    end

    describe "reservations" do
      it "=== Returns an array of reservations ===" do
        reservations = @front_desk.reservations(@date)
        expect(reservations).must_be_kind_of Array
        reservations.each do |reservation|
          reservation.must_be_kind_of Reservation
        end
      end
    end
  end
  
end
