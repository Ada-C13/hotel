require 'test_helper'
require 'time'

describe "FrontDesk class" do

  describe "Initializer" do
    it "is an instance of FrontDesk" do
      hotel = Hotel::FrontDesk.new(rooms: [], reservations: [])
        expect(hotel).must_be_kind_of Hotel::FrontDesk
    end

  end  
end