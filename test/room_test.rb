require_relative "test_helper"

describe "Room" do
  before do
    @room = Hotel::Room.new(1, 200)
  end

  describe "initialize" do
      it "creates an instance of Room" do
        expect(@room).must_be_kind_of Hotel::Room
        expect(@room).must_respond_to :cost
      end
    end
end