require_relative "test_helper"

describe Hotel::FrontDesk do
  before do
    @desk_instance = Hotel::FrontDesk.new
    @date_instance = Hotel::DateRange.new(
      start_date: Date.new(2021, 01, 01),
      end_date: Date.new(2021, 01, 03)
    )
    @res_instance = Hotel::Reservation.new(
      date_range: @date_instance,
      room: 2
    )
    @room_list = @desk_instance.available_rooms(@date_instance)
    @reserved = @desk_instance.reserve_room(@date_instance)
    @range_res = @desk_instance.range_reservations(@date_instance)
    @room_res = @desk_instance.find_room_res(2, @range_res)
  end

  describe "initialize" do
    it "is an instance of FrontDesk" do
      expect(@desk_instance).must_be_kind_of Hotel::FrontDesk
    end

    # ! how to test these variable
    # it "Class.rooms is a type of Array" do
    #   expect(Hotel::FrontDesk.rooms).must_be_kind_of Array
    # end

    it "reservations is a type of Array" do
      expect(@desk_instance.reservations).must_be_kind_of Array
    end

    it "calendar is a type of Hash" do
      expect(@desk_instance.calendar).must_be_kind_of Hash
    end

    it "calendar is a type of Hash" do
      expect(@desk_instance.calendar).must_be_kind_of Hash
    end

    it "rooms is a type of array" do
      expect(@desk_instance.rooms).must_be_kind_of Array
    end

    it "rooms array has 20 items" do
      expect(@desk_instance.rooms.length).must_equal 20
    end
  end  


 

  describe "wave 1" do

    describe "list_rooms" do
      it "takes date range and returns a list" do
        expect(@desk_instance.list_rooms).must_be_kind_of Array
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

      it "creates the same number of hash keys as there are nights in the range" do
        nights = @date_instance.nights
        expect(@cal_instance.length).must_equal 2 
      end

    end

    describe "reserve_room" do
      it "creates a Reservation" do
        expect(@reserved).must_be_kind_of Hotel::Reservation
      end
      
    end

    describe "date_reservations" do
      before do
        date = Date.new(2021, 01, 01)
        @date_res = @desk_instance.date_reservations(date)
      end

      it "raises an ArgumentError if no reservations for date" do
        # ! TODO
      end

      it "raises an ArgumentError if date is not a date" do
        # ! TODO
      end

      it "returns an array of reservations for a single date" do
        expect(@date_res).must_be_kind_of Array
        expect(@date_res[0]).must_be_kind_of Hotel::Reservation
      end

    end

    describe "range_reservations" do 
      it "returns an array of reservations for a range of reservations" do
        expect(@range_res).must_be_kind_of Array
        expect(@range_res[0]).must_be_kind_of Hotel::Reservation
      end

      it "raises an ArgumentError if no reservations for date" do
        # ! TODO
      end

      it "raises an ArgumentError if date is not a date" do
        # ! TODO
      end

      it "removes duplicates" do
        # ! TODO
      end

    end

    xdescribe "find_room_res" do
      it "returns a list of reservations" do
        temp = nil
        @room_res.each do |res|
          temp = res
          puts temp.length
        end
        
        expect(@room_res).must_be_kind_of Array
        @room_res[0].must_be_kind_of Hotel::Reservation


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