require_relative "test_helper"

describe Hotel::FrontDesk do
  before do
    @desk_instance = Hotel::FrontDesk.new
    @date_instance = Hotel::DateRange.new(
      start_date: Date.today + 1,
      end_date: Date.today + 3
    )
    @res_instance = Hotel::Reservation.new(
      date_range: @date_instance,
      room: 2
    )
    @room_list = @desk_instance.available_rooms(@date_instance)
    @reserved = @desk_instance.reserve_room(@date_instance)
  end

  describe "initialize" do
    it "is an instance of FrontDesk" do
      expect(@desk_instance).must_be_kind_of Hotel::FrontDesk
    end

    it "rooms is a type of array" do
      expect(@desk_instance.reservations).must_be_kind_of Array
    end

    it "rooms is a type of array" do
      expect(@desk_instance.calendar).must_be_kind_of Hash
    end

    it "rooms is a type of array" do
      expect(@desk_instance.rooms).must_be_kind_of Array
    end

    it "rooms array has 20 items" do
      expect(@desk_instance.rooms.length).must_equal 20
    end
  end  

  describe "list_rooms" do
    it "takes date range and returns a list" do
      expect(@desk_instance.list_rooms).must_be_kind_of Array
    end
  end
 

  describe "wave 1" do

    describe "reserve_room" do
      it "creates a Reservation" do
        expect(@reserved).must_be_kind_of Hotel::Reservation
      end
      
    end
    
    describe "populate_calendar" do
      before do
        @cal_instance = @desk_instance.populate_calendar(@res_instance)
      end

      it "takes a reservation and loops through date ranges" do
        @desk_instance.populate_calendar(@res_instance)
          @res_instance.date_range.dates.each do |date|
            date.must_be_kind_of Date
          end
      end

      it "returns a hash" do
        expect(@cal_instance).must_be_kind_of Hash
      end

      it "creates a hash key for every date" do
        expect(@cal_instance.length).must_equal 3 
      end

    end

    xdescribe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        date = Date.today + 1
        reservation_list = @desk_instance.date_reservations(date)

        expect(reservation_list).must_be_kind_of Array

        reservation_list.each do |res|
          res.must_be_kind_of Hotel::Reservation
        end
      end
    end
  end

  describe "wave 2" do
    describe "available_rooms" do
      before do
        
      end

      it "takes date range and returns a list" do
        expect(@room_list).must_be_kind_of Array
      end
    end
  end
end