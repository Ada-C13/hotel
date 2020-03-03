require_relative 'test_helper'

describe "Front Desk" do 
  let(:front_desk) { HotelBooking::FrontDesk.new }

  describe "Initialize" do
    it "creates a new instance of FrontDesk" do
      expect(front_desk).must_be_instance_of HotelBooking::FrontDesk
    end

    it "keeps track of hotel rooms" do
      expect(front_desk).must_respond_to :rooms
      expect(front_desk.rooms).must_equal []
    end

    it "keeps track of hotel reservations" do
      expect(front_desk).must_respond_to :reservations
      expect(front_desk.reservations).must_equal []
    end

    # there are 20 rooms in the rooms array
    
  end
end