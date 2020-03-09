require_relative "test_helper"

describe "Room class" do
  describe "Initializer" do
    let(:check_in_date) { Date.new(2001, 2, 1) }
    let(:check_out_date) { Date.new(2001, 2, 3) }
    let(:date_range_1) { Date_Range.new(check_in_date, check_out_date) }
    it "is an instance of Room" do
      test_room = Room.new(1)
      expect(test_room).must_be_kind_of Room
    end

    it "Can create mutliple reservations for 1 room" do
      room = Room.new(1)
      all_res = []
      5.times do |index|
        all_res << room.create_new_reservation(Date.today, Date.today + 3, hotel_block_reservation = false)
      end
      expect(all_res.length).must_equal 5
    end

    it "Can check overlap within rooms" do
      room = Room.new(1)
      requested_date_range = Date_Range.new(check_in_date, check_out_date)
      room.create_new_reservation(check_in_date, check_out_date, hotel_block_reservation = false)
      all_res = room.check_overlap_with_room_reservations(requested_date_range)
      expect(all_res).must_equal false
    end
  end
end
