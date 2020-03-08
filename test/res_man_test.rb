require_relative 'test_helper.rb'

describe "reservation manager test suite" do
  before do
    @front_desk = Stayappy::ReservationManager.new
  end

  xdescribe "initialize" do

    it "verifies that all_rooms array has correct starting length" do
      expect(@front_desk.all_rooms.count).must_equal 20
    end

    it "verifies that available_rooms array has correct starting length" do
      expect(@front_desk.available_rooms.count).must_equal 20
    end

    it "verifies that unavailable_rooms array has correct starting value" do
      expect(@front_desk.unavailable_rooms.count).must_equal 0
    end

    it "verifies that bookings array has correct starting value" do
      expect(@front_desk.unavailable_rooms.count).must_equal 0
    end
  end 

  describe "assign_room" do
    describe "assign_room can bump reserved rooms out of available_rooms   array" do

      it "decreases available_rooms array length by one or more" do
        @front_desk.assign_room(reservation)
        expect(@front_desk.available_rooms.count).must_equal 19
        expect(@front_desk.unavailable_rooms.count).must_equal 1
      end
    end
  

    describe "assign_room can raise error if the available_rooms array is empty" do

      it "raises an error if there are no available rooms" do
        @front_desk.available_rooms.clear
        expect { @front_desk.assign_room }.must_raise ArgumentError
      end
    end
  end
 
  xdescribe "book_of_bookings method tests" do
    it "book_of_bookings data type verification test" do
      @front_desk.book_of_bookings(reservation)
      expect(@front_desk.book_of_bookings).must_be_kind_of Hash 
    end

    it "BOOKINGS variable count increases in length" do
      pre_book = @front_desk.bookings.length
      @front_desk.make_reservation(reservation)
      expect(@front_desk.bookings.length).must_equal pre_book + 1
    end
  end

  describe "make_reservation method" do
    it "only assigns a room if no exception is raised by date_vet" do
      stay = (Date.new(2020, 3, 10)..Date.new(2020, 3, 12))
      expect { @front_desk.make_reservation(stay) }.must_output @front_desk.reservation 
    end
  end

  describe "reservations_by_date method" do
    it "shows the reservations for the dates searched for" do
      expect(@front_desk.reservations_by_date).must_output Array
    end
  end

  describe "reservation_by_room method" do 
    it "shows the reservations for the room searched for" do
      expect(@front_desk.reservations_by_room(Date.new)).must_output Array
    end
  end

  # describe "view_vacancy method" do
  #   it "" do
  #     expect().must_
  #   end
  # end

  # describe "view_occupancy method" do
  #   it "" do
  #     expect().must_
  #   end
  # end

  # describe "view_all method" do
  #   it "" do
  #     expect().must_
  #   end
  # end
end