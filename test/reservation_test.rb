require_relative "test_helper"

describe "Reservation class" do

  # Arrange
  before do
    date_range = Hotel::DateRange.new(Date.today, Date.today + 7)

    hotel_manager = Hotel::HotelManager.new()

    room_id = hotel_manager.available_room_ids(date_range)[0]
    room = hotel_manager.find_room_by_id(room_id)

    @reservation = Hotel::Reservation.new(date_range: date_range, rooms: [room])
  end

  describe "#initialize" do
    it "creates an id, date_range, rooms" do
      expect(@reservation).must_respond_to :id
      expect(@reservation).must_respond_to :date_range
      expect(@reservation).must_respond_to :rooms

      expect(@reservation.id.length).must_equal 16 
      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
      expect(@reservation.rooms[0]).must_be_kind_of Hotel::Room

      expect(@reservation.date_range.start_date).must_equal Date.today
      expect(@reservation.date_range.end_date).must_equal Date.today + 7
      expect(@reservation.rooms[0].num).must_equal 1
    end
  end

  describe "#total_cost (individual)" do
    it "returns the correct total cost for a given reservation" do
      expect(@reservation.total_cost).must_be_instance_of Float

      expect(@reservation.total_cost).must_be_close_to (7 * 200.00), 0.01
    end
  end
end
