require_relative 'test_helper'

describe "Room class" do
  # Arrange
  before do 
    @room = Hotel::Room.new(id: 5)
  end 

  describe "#initialize" do 

    it "creates id (room number)" do 
      expect(@room).must_respond_to :id
      expect(@room.id).must_be_instance_of Integer
      expect(@room.id).must_equal 5
    end 
  end  
end 

