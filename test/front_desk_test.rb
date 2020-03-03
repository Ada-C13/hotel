require_relative 'test_helper'

describe "Front Desk" do 
  let(:front_desk) { HotelBooking::FrontDesk.new }

  describe "Initialize" do
    it "creates a new instance of FrontDesk" do
      front_desk.must_be_instance_of HotelBooking::FrontDesk
    end

    it "keeps track of hotel rooms" do
      front_desk.must_respond_to :rooms
      front_desk.rooms.must_equal []
    end

    it "keeps track of hotel reservations" do
      front_desk.must_respond_to :reservations
      front_desk.reservations.must_equal []
    end
    
  end
end