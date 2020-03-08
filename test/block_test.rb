require_relative 'test_helper'

describe "Block class" do
  before do 
    @date_range = Hotel::DateRange.new(Date.new(2020, 05, 11), Date.new(2020, 05, 16))

    rooms = []

    3.times do |i|
      room = Hotel::Room.new(id: i + 1)
      rooms << room
    end 

    @block = Hotel::Block.new(@date_range, rooms: rooms)
  end


  describe "#initialize" do 
    it "creates date_range, rooms and reservation" do

      expect(@block).must_respond_to :date_range
      expect(@block).must_respond_to :rooms

      expect(@block.date_range).must_be_kind_of Hotel::DateRange
      expect(@block.date_range.start_date).must_be_kind_of Date
      expect(@block.date_range.end_date).must_be_kind_of Date

      expect(@block.rooms).must_be_kind_of Array

      expect(@block.rooms.length).must_equal 3

      @block.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room 
      end 
    end 
  end 

  describe ".generate_id" do
    it "creates a non-consecutive ID" do
      id = Hotel::Block.generate_id 
      expect(id).must_be_kind_of String
      expect(id.length).must_equal 8 
      expect(id).must_include "BL000"
    end  
  end 
end 