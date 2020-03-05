require_relative 'test_helper'

describe "Room class" do
  # Arrange
  before do 
    @room = Hotel::Room.new(5)
  end 

  describe "#initialize" do 

    it "creates number" do 
      expect(@room).must_respond_to :number
      expect(@room.number).must_be_instance_of Integer
      expect(@room.number).must_equal 5 
    end 

    it "rasise an ArgumentError if number is not between 1 and 20" do 
      expect{Hotel::Room.new(21)}.must_raise ArgumentError
      expect{Hotel::Room.new(0)}.must_raise ArgumentError
      expect{Hotel::Room.new(100)}.must_raise ArgumentError
    end 

    it "raises an ArgumentError if number is not an Integer" do 

      expect{Hotel::Room.new("string")}.must_raise ArgumentError
      expect{Hotel::Room.new([])}.must_raise ArgumentError
      expect{Hotel::Room.new("123")}.must_raise ArgumentError
    end 
  end  

end 

