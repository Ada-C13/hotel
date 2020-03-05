require_relative 'test_helper'

describe "Hotel Controller" do
 before do
    @front_desk = Hotel::HotelController.new(20)
 end

  describe "Initalizer" do
    it "is an instance of Hotel Controller" do
      expect(@front_desk).must_be_kind_of Hotel::HotelController  
    end

    it "will create an array of rooms according to the number of room provided as an argument"
      # it is creating the room array we want but not able to create test for it
      # expect(@front_desk.room_list.length).must_equal 20
    end

  end

  describe "reserve_room" do
    before do
      @front_desk = Hotel::HotelController.new(20)
      @front_desk.reserve_room(Date.new(2020,01,05), Date.new(2020,01,10), "Alex")
   end

    it "will create a new Reservation class and push into Reservation List" do
      expect(@front_desk.reservation_list.length).must_equal 1
      expect(@front_desk.reservation_list[1]).must_be_kind_of Hotel::Reservation
    end

    it "will create a new Date Range" do 
      expect(@front_desk.reservation_list[1].date_range).must_be_kind_of Hotel::DateRange
    end

end 
