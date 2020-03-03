require 'test_helper'

describe "Receptionist class" do

  describe "Initializer" do
    it "is an instance of room" do
      room = Hotel::Room.new(id: 34, status: false, reservations: [])
        expect(room).must_be_kind_of Hotel::Room
    end
  end  
end