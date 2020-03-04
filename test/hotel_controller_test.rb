require_relative 'test_helper'

describe "Hotel Controller" do
  def build_hotel_controller
    return Hotel::HotelController.new
      #reservation_list = {1 => {start_date: Date.parse("2020-01-01"), end_date: Date.parse("2020-01-05")} }
  end
  
  describe "Initalizer" do
    it "is an instance of Hotel Controller" do
      front_desk = build_hotel_controller
      expect(front_desk).must_be_kind_of Hotel::HotelController
    end
  end

  describe "reserve_room" do
    before do
      @front_desk = build_hotel_controller
    end

    it "will create a new Reservation class and push into Reservation List" do
      @front_desk.reserve_room( Date.new(2010,02,05), Date.new(2010,02,07), 3 )
      expect(@front_desk.reservation_list.length).must_equal 1
    end
  end
end 
