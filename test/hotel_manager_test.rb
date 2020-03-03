require 'test_helper'
require 'time'

describe "Receptionist class" do

  describe "Initializer" do
    it "is an instance of FrontDesk" do
      hotel = Hotel::Receptionist.new(rooms: [], reservations: [])
        expect(hotel).must_be_kind_of Hotel::Receptionist
    end
    

  end  
end