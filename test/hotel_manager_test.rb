require_relative "test_helper"

describe "HotelManager" do
  describe "initialize" do
    it "creates an instance of HotelManager" do
      hotel_manager = Hotel::HotelManager.new

      expect(hotel_manager).must_be_kind_of Hotel::HotelManager
    end
  end
end