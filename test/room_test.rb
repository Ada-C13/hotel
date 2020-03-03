require_relative 'test_helper'

describe "Room class" do
  # Arrange
  before do 
    @room = Hotel::Room.new(5)
  end 

  describe "#initialize" do 
    it "Creates number and vacancy" do 
      expect(@room).must_respond_to :number
      expect(@room).must_respond_to :vacancy

      expect(@room.number).must_be_instance_of Integer
      expect(@room.vacancy).must_be_instance_of TrueClass 

      expect(@room.number).must_equal 5 
      expect(@room.vacancy).must_equal true
    end 

    it "Rasise an ArgumentError if number is not between 1 and 20" do 
      expect{
        Hotel::Room.new(21)
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new(0)
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new(100)
      }.must_raise ArgumentError
      
    end 

    it "Raises an ArgumentError if number is not an Integer" do 

      # Act & Assert
      expect{
        Hotel::Room.new("string")
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new([])
      }.must_raise ArgumentError

      expect{
        Hotel::Room.new("123")
      }.must_raise ArgumentError
    end 
  end  
end 

