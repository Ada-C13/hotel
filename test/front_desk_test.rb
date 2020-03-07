require_relative "test_helper"

describe Hotel::FrontDesk do
  before do
@desk_instance = Hotel::FrontDesk.new
  end

  describe "initialize" do
    it "is an instance of FrontDesk" do
      expect(@desk_instance).must_be_kind_of Hotel::FrontDesk
    end

    it "rooms is a type of array" do
      expect(@desk_instance.rooms).must_be_kind_of Array
    end

    it "rooms array has 20 items" do
      expect(@desk_instance.rooms.length).must_equal 20
    end
  end  


 

  describe "wave 1" do

    describe "reserve_room" do
      before do
        @date_instance = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 3)
    @desk_instance.available_rooms(@date_instance)
      end

    
      it "creates a Reservation" do
        @reserved = @desk_instance.reserve_room(@date_instance)
        expect(@reserved).must_be_kind_of Hotel::Reservation
      end
      
    end

    xdescribe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @desk_instance.reservations(@date)

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
        @date_instance = Hotel::DateRange.new(start_date: Date.today + 1, end_date: Date.today + 3)
    @desk_instance.available_rooms(@date_instance)
      end

      it "takes date range and returns a list" do

        room_list = @desk_instance.available_rooms(@date_instance)
        expect(room_list).must_be_kind_of Array
      end
    end
  end
end