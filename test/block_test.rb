require_relative "test_helper"

describe "Hotel::Block" do

  before do
    @start_date = Date.new(2017, 01, 01)
    @end_date   = @start_date + 3
    @rooms      = [3,4,5]
    @rate       = 150
    @block      = Hotel::Block.new(@start_date, @end_date, @rooms, @rate)
  end

  describe "constructor" do
    it "can be initialized with two dates, an array of rooms and a rate" do
      expect(@block).must_be_kind_of Hotel::Block
      expect(@block.range.start_date).must_equal @start_date
      expect(@block.range.end_date).must_equal @end_date
      expect(@block.rooms).must_be_kind_of Array
      expect(@block.rooms).must_equal @rooms
      expect(@block.rate).must_equal @rate
    end

    it "does not accept a number as rooms" do
      # create a block with rooms = 3. Must raise argumenterror
      expect{ Hotel::Block.new(@start_date, @end_date, 3, @rate) }.must_raise ArgumentError
    end

    it "does not accept invalid rates" do
      # create a block with rate = -1. Must raise argumenterror
      expect{ Hotel::Block.new(@start_date, @end_date, @rooms, -1) }.must_raise ArgumentError
      # create a block with rate = "100". Must raise argumenterror
      expect{ Hotel::Block.new(@start_date, @end_date, @rooms, "100") }.must_raise ArgumentError
      # create a block with rate = nil. Must raise argumenterror
      expect{ Hotel::Block.new(@start_date, @end_date, @rooms, nil) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if invalid dates provided" do
      end_date1   = @start_date - 1
      end_date2   = "2017/01/04"
      # start date can not be after end date
      expect{ Hotel::Block.new(@start_date, end_date1, @rooms, @rate) }.must_raise ArgumentError
      # date can not be a string
      expect{ Hotel::Block.new(@start_date, end_date2, @rooms, @rate) }.must_raise ArgumentError
      # start date can not be the same as end date
      expect{ Hotel::Block.new(@start_date, @start_date, @rooms, @rate) }.must_raise ArgumentError
    end
  end

  describe "cost" do
    it "returns a number" do
      expect(@block.cost).must_be_kind_of Numeric
    end

    it "calculates the cost" do
      # block cost for 3 nights, 3 rooms, at $150 room rate
      expect(@block.cost).must_equal 1350
    end
  end
  
end