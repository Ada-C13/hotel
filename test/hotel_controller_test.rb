require_relative 'test_helper'

describe Hotel::Controller do
  describe "initialize" do
    let(:hotel_controller) {Hotel::Controller.new}

    it "is an instance of HotelController" do
      expect(hotel_controller).must_be_kind_of Hotel::Controller
    end

    it "stores an array of all reservations (can be empty)" do
      expect(hotel_controller.all_reservations).must_be_kind_of Array
      expect(hotel_controller.all_reservations.length).must_equal 0
    end

    # add this test here?
    # it "calls create_rooms upon initialization" do

    # end
  end

  describe "reserve_with_range" do
    let(:hotel_controller) {Hotel::Controller.new}
    before do
      start_date = Date.new(2020, 1, 1)
      end_date = Date.new(2020, 1, 2)
      @room_id = 5
      @date_range = Hotel::DateRange.new(start_date, end_date)
      @new_reservation = Hotel::Reservation.new(@date_range,@room_id)
    end

    it "creates a new reservation" do
      expect(hotel_controller.reserve_with_range(@date_range)).must_be_kind_of Hotel::Reservation
    end

  end


# test for private method(s)
  describe "create_rooms" do
    let(:hotel_controller) {Hotel::Controller.new}

    it "creates an Array of 20 Room objects" do
      expect(hotel_controller.rooms).must_be_kind_of Array
      expect(hotel_controller.rooms.length).must_equal 20
      hotel_controller.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "creates the correct ids for each room" do
      expect(hotel_controller.rooms[0].room_id).must_equal 1
      expect(hotel_controller.rooms[19].room_id).must_equal 20
      expect(hotel_controller.rooms[20]).must_be_nil
    end

  end
end