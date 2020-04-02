require_relative "test_helper"

describe "Room class" do
  # Arrange
  before do
    @room = Hotel::Room.new(num: 5)
  end

  describe "#initialize" do
    it "creates a room number and cost" do
      expect(@room).must_respond_to :num
      expect(@room).must_respond_to :cost
      expect(@room.num).must_be_instance_of Integer
      expect(@room.num).must_equal 5
      expect(@room.cost).must_be_close_to 200.00, 0.01
    end
  end
end
