require_relative "test_helper"

describe Hotel::HotelController do 
  before do
    @hotel_controller = Hotel::HotelController.new([])
    @date = Date.parse("2020-08-04")
  end
 describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        rooms = @hotel_controller.rooms
        expect(rooms).must_be_kind_of Array
      end
    end
  end
  
end