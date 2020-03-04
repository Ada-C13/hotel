require_relative "test_helper"

describe "HotelManager" do
  before do
    @hotel_manager = Hotel::HotelManager.new
  end

  describe "initialize" do
    it "creates an instance of HotelManager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
      expect(@hotel_manager).must_respond_to :rooms
      expect(@hotel_manager).must_respond_to :total_reservations
    end
  end

  describe "initialize_rooms" do
    before do
      @hotel_manager.initialize_rooms(20)
    end

    it "creates an array" do
      expect(@hotel_manager.rooms).must_be_kind_of Array
      expect(@hotel_manager.rooms.length).must_equal 20
    end

    it "should contain Room objects" do
      @hotel_manager.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "raises ArgumentError if non-integer is provided" do
      expect{@hotel_manager.initialize_rooms("twenty")}.must_raise ArgumentError
    end
  end

  describe "list_all_rooms" do
    it "returns an array" do
      @hotel_manager.rooms.push("this is a room")
      rooms = @hotel_manager.list_all_rooms

      expect(rooms).must_be_kind_of Array
    end

    it "contains Room objects within the array" do
      #TODO after Room class has been created
    end

    it "returns empty array if there are no rooms" do
      @hotel_manager.rooms.clear()
      rooms = @hotel_manager.list_all_rooms

      expect(rooms).must_equal []
    end
  end

  describe "reserve_room" do
    let(:reservation) {
      date_range = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      reservation = @hotel_manager.reserve_room(date_range)
    }

    it "creates a Reservation instance" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds 1 to total_reservations" do
      current_reservations = @hotel_manager.total_reservations
      reservation

      expect(@hotel_manager.total_reservations).must_equal current_reservations + 1
    end

    it "raises ArgumentError if invalid date is provided" do
      expect{(
        @hotel_manager.reserve_room(
          Hotel::DateRange.new(
            Date.new(2020,5,10), Date.new(2020,5,9)
          )
        )
      )}.must_raise ArgumentError 
    end
  end

  describe "find_room" do
    before do
      @hotel_manager.initialize_rooms(20)
    end

    it "returns correct room" do
      expect(@hotel_manager.find_room(2).cost).must_equal 200
      expect(@hotel_manager.find_room(2).number).must_equal 2
    end
  end

  describe "list_reservations" do
    before do
      @hotel_manager.initialize_rooms(20)
      date_range1 = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      date_range2 = Hotel::DateRange.new(Date.new(2020,5,25), Date.new(2020,5,27))
      date_range3 = Hotel::DateRange.new(Date.new(2020,5,28), Date.new(2020,5,29))

      @hotel_manager.find_room(1).reservations.push(Hotel::Reservation.new(date_range1), Hotel::Reservation.new(date_range2), Hotel::Reservation.new(date_range3))
    end

    describe "list_reservations_by_room" do
      it "returns an Array of Reservations" do
        date_range = Hotel::DateRange.new(Date.new(2020,5,25), Date.new(2020,5,29))
        expect(@hotel_manager.list_reservations_by_room(1, date_range)).must_be_kind_of Array
  
        @hotel_manager.list_reservations_by_room(1, date_range).each do |reservation|
          expect(reservation).must_be_kind_of Hotel::Reservation
        end
      end
  
      it "returns the correct reservations" do
        date_range = Hotel::DateRange.new(Date.new(2020,5,26), Date.new(2020,5,29))

        expect(@hotel_manager.list_reservations_by_room(1, date_range).length).must_equal 2
      end

      it "returns an empty Array if there are no reservations during the date range" do
        date_range = Hotel::DateRange.new(Date.new(2020,6,1), Date.new(2020,6,5))
  
        expect(@hotel_manager.list_reservations_by_room(1, date_range)).must_equal []
      end
  
      it "raises ArgumentError if invalid date is provided" do
        date1 = Date.new(2020,6,1)
        date2 = "it's a date"
        
        expect{(@hotel_manager.list_reservations_by_room(1, Hotel::DateRange.new(date1, date2)))}.must_raise ArgumentError
      end
    end

    describe "list_reservations_by_date" do
      it "returns an Array of Reservations" do
        date = Date.new(2020,5,25)
        expect(@hotel_manager.list_reservations_by_date(date)).must_be_kind_of Array
  
        @hotel_manager.list_reservations_by_date(date).each do |reservation|
          expect(reservation).must_be_kind_of Hotel::Reservation
        end
      end
  
      it "returns an empty Array if no reservations include the date" do
        date = Date.new(2020,6,1)
  
        expect(@hotel_manager.list_reservations_by_date(date)).must_equal []
      end

      it "returns the correct reservations" do
        date_range1 = Hotel::DateRange.new(Date.new(2020,5,25), Date.new(2020,5,27))
        date_range2 = Hotel::DateRange.new(Date.new(2020,5,28), Date.new(2020,5,29))
  
        @hotel_manager.find_room(2).reservations.push(Hotel::Reservation.new(date_range1), Hotel::Reservation.new(date_range2))
  
        date = Date.new(2020,5,26)

        expect(@hotel_manager.list_reservations_by_date(date).length).must_equal 2
      end

  end
  end
end