require_relative "test_helper"

describe "BlockReservation" do
  describe "change_room_status" do
    it "discount rate for the block reservation" do
      block = Hotel::BlockReservation.new(
        name = "Micky",
        date_range = Hotel::DateRange.new("2020-3-13", "2020-3-15"),
        room_num = 1,
        discount_rate = 150
      )
      block.change_room_status
      expect(block.status).must_equal :UNAVAILABLE
    end
  end
end