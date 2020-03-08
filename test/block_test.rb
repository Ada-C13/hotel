require_relative 'test_helper'
require 'date'

describe "Block" do
  describe "#initialize" do 
    it "Creates an instance of Block" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [7, 8, 9]
      discount_rate = 10
      block = Hotel::Block.new(date_range, room_collection, discount_rate)

      expect(block).must_be_kind_of Hotel::Block
    end

    it "Keeps track of date_range" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [7, 8, 9]
      discount_rate = 10
      block = Hotel::Block.new(date_range, room_collection, discount_rate)

      expect(block).must_respond_to :date_range
      expect(block.date_range).must_be_kind_of Hotel::DateRange
      expect(block.date_range.start_date).must_equal date_range.start_date
    end

    it "Keeps track of room_collection" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [7, 8, 9]
      discount_rate = 10
      block = Hotel::Block.new(date_range, room_collection, discount_rate)

      expect(block).must_respond_to :room_collection
      expect(block.room_collection).must_be_kind_of Array
      expect(block.room_collection.length).must_equal 3
      expect(block.room_collection[0]).must_equal 7
      expect(block.room_collection[-1]).must_equal 9
    end

    it "Keeps track of discount_rate" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [7, 8, 9]
      discount_rate = 10
      block = Hotel::Block.new(date_range, room_collection, discount_rate)

      expect(block).must_respond_to :discount_rate
      expect(block.discount_rate).must_be_kind_of Integer
      expect(block.discount_rate).must_equal 10
    end

    it "Raises and exception if room_collection is not an array" do 
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = "7, 8, 9"
      discount_rate = 10
      
      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate)
      }.must_raise ArgumentError
      

      # if not an array
      # if array contains elements other than integers
      # if numbers are less than 1 and greater than 20
    end

    it "Raises an exception if room collection has more than 5 rooms" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [7, 8, 9, 10, 11, 12]
      discount_rate = 10

      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate)
      }.must_raise ArgumentError
    end

    it "Raises an exception if room collection has room numbers < 0 or > 20" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [10, 19, 21]
      room_collection_2 = [0, 3, 8]
      discount_rate = 10

      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate)
      }.must_raise ArgumentError

      expect{
        Hotel::Block.new(date_range, room_collection_2, discount_rate)
      }.must_raise ArgumentError
    end

    it "Raises an exception if room_collection contains elements other than integers" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [10, "sixteen", 20]
      discount_rate = 10

      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate)
      }.must_raise ArgumentError
    end

    it "Raises an exception for invalid discount_rate" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [10, 16, 20]
      discount_rate = -1
      discount_rate_2 = 51
      discount_rate_3 = "ten"

      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate)
      }.must_raise ArgumentError

      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate_2)
      }.must_raise ArgumentError

      expect{
        Hotel::Block.new(date_range, room_collection, discount_rate_3)
      }.must_raise ArgumentError

      # should not be less than 0 or greater than 50%
      # should only be of type integer

    end
  end

  describe "#calculate_cost" do
    it "Calculates cost applying the discount" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [10, 14, 16, 20]
      discount_rate = 20

      block = Hotel::Block.new(date_range, room_collection, discount_rate)
      expect(block.calculate_cost).must_equal 640
    end

    it "Does not add up the discount if it is zero" do
      date_range = Hotel::DateRange.new(Date.new(2020, 4, 10), Date.new(2020, 4, 14))
      room_collection = [10, 14, 16, 20]
      discount_rate = 0

      block = Hotel::Block.new(date_range, room_collection, discount_rate)
      expect(block.calculate_cost).must_equal 800
    end
  end
end