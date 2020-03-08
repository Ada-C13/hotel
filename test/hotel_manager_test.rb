require_relative "test_helper"

describe "HotelManager" do
  before do
    @hotel_manager = Hotel::HotelManager.new
    @hotel_manager.initialize_rooms(20)
  end

  describe "initialize" do
    it "creates an instance of HotelManager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
      expect(@hotel_manager).must_respond_to :rooms
      expect(@hotel_manager).must_respond_to :total_reservations
    end
  end

  describe "initialize_rooms" do
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
    before do
      @rooms = @hotel_manager.list_all_rooms
    end

    it "returns an array" do
      expect(@rooms).must_be_kind_of Array
    end

    it "contains Room objects within the array" do
      expect(@rooms[0]).must_be_kind_of Hotel::Room
    end

    it "returns empty array if there are no rooms" do
      @hotel_manager.rooms.clear()
      expect(@rooms).must_equal []
    end
  end

  describe "reserve_room" do
    let(:date_range) {
      date_range = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
    }
    let(:reservation) {
      @hotel_manager.reserve_room(date_range, 1)
    }
    let(:reserve_rooms) {
      20.times do |i|
        @hotel_manager.reserve_room(date_range, i + 1)
      end
    }

    it "creates a Reservation instance" do
      expect(reservation).must_be_kind_of Hotel::Reservation
    end

    it "adds 1 to total_reservations" do
      current_reservations = @hotel_manager.total_reservations
      reservation
      expect(@hotel_manager.total_reservations).must_equal current_reservations + 1
    end

    it "adds reservation to associated room" do      
      found_room = @hotel_manager.find_room(1)
      current_reservations = found_room.reservations.length
      reservation

      expect(found_room.reservations.length).must_equal current_reservations + 1
    end

    it "adds valid room number to the Reservation" do
      expect(reservation.room_number).must_be :>=, 1
      expect(reservation.room_number).must_be :<=, 20
    end

    it "raises ArgumentError if no rooms are available" do
      reserve_rooms
      expect{@hotel_manager.reserve_room(date_range)}.must_raise ArgumentError
    end

    it "makes a reservation if date_range provided starts on checkout day of existing reservations" do
      reserve_rooms
      date_range = Hotel::DateRange.new(Date.new(2020,5,14), Date.new(2020,5,15))

      expect(@hotel_manager.reserve_room(date_range)).must_be_kind_of Hotel::Reservation
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

    it "sends correct cost to new Reservation" do
      cost = @hotel_manager.find_room(1).cost
      expect(reservation.cost).must_equal 200
    end
  end

  describe "reserve_block" do
    before do
      date_range = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))

      @reserve_block = @hotel_manager.reserve_block(date_range, (1..4).to_a, 0.15)
    end

    it "creates an instance of HotelBlock" do
      expect(@reserve_block).must_be_kind_of Hotel::HotelBlock
    end

    it "contains an array of Room instances" do
      expect(@reserve_block.rooms).must_be_kind_of Array
      expect(@reserve_block.rooms[0]).must_be_kind_of Hotel::Room
    end
  end

  describe "find_room" do
    it "returns correct room" do
      expect(@hotel_manager.find_room(2).cost).must_equal 200
      expect(@hotel_manager.find_room(2).number).must_equal 2
    end
  end

  describe "list_reservations" do
    before do
      date_range1 = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      date_range2 = Hotel::DateRange.new(Date.new(2020,5,25), Date.new(2020,5,27))
      date_range3 = Hotel::DateRange.new(Date.new(2020,5,28), Date.new(2020,5,29))

      @hotel_manager.reserve_room(date_range1, 1)
      @hotel_manager.reserve_room(date_range2, 1) 
      @hotel_manager.reserve_room(date_range3, 1)
      
      @hotel_manager.reserve_room(date_range1, 2) 
      @hotel_manager.reserve_room(date_range2, 2) 
      @hotel_manager.reserve_room(date_range3, 2)
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
        date = Date.new(2020,5,26)

        expect(@hotel_manager.list_reservations_by_date(date).length).must_equal 2
      end
    end

    describe "list_available_rooms" do
      before do
        @date_range = Hotel::DateRange.new(Date.new(2020,5,10), Date.new(2020,5,14))
      end

      it "returns an array of Room instances" do
        expect(@hotel_manager.list_available_rooms(@date_range)).must_be_kind_of Array
      end

      it "returns correct rooms" do
        expect(@hotel_manager.list_available_rooms(@date_range).length).must_equal 18
      end

      it "returns an empty array if no rooms are available" do
        # reserve the remaining rooms
        (3..20).each do |i|
          @hotel_manager.reserve_room(        @date_range, i)
        end

        expect(@hotel_manager.list_available_rooms(@date_range)).must_equal []
      end
    end
  end

end