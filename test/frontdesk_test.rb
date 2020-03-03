require_relative 'test_helper'

describe "Front Desk" do
  
  describe "Initialize" do

    before do
      @front_desk = Hotel::FrontDesk.new
    end

    it "can create an instance of FrontDesk" do
      expect(@front_desk).must_be_kind_of Hotel::FrontDesk
    end

    it "can return a list of 20 rooms" do
      expect(@front_desk.rooms).must_equal [*1..20]
    end
  end

  describe "add_reservation" do

    before do
        @start_date = "2019-1-4"
        @end_date = "2019-1-7"
        @front_desk = Hotel::FrontDesk.new()
      end

    it "can add a new reservation to the reservation collection" do
        @front_desk.add_reservation(@start_date, @end_date, 1)
        expect(@front_desk.all_reservations.length).must_equal 1
    end

    it "can return a list of 20 rooms" do
      expect(@front_desk.rooms).must_equal [*1..20]
    end
  end

  describe "find_reservation_by_date" do

    before do
        @front_desk = Hotel::FrontDesk.new()
        @front_desk.add_reservation("2019-1-4","2019-1-7", 1)
        @front_desk.add_reservation("2019-1-1","2019-1-5", 1)
        @front_desk.add_reservation("2019-1-4","2019-1-5", 1)
        @front_desk.add_reservation("2019-1-3","2019-1-6", 1)
      end

    it "can return a list of reservations by date" do
      expect(@front_desk.find_reservation_by_date("2019-1-4")).must_be_kind_of Array
    end
  end
end