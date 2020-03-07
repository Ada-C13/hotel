require "date"
require_relative "test_helper"

describe "Block class" do
  before do
    @date_range = Hotel::DateRange.new(check_in: Date.new(2020, 2, 24), check_out: Date.new(2020, 2, 25))
    rooms = [1, 2, 3]
    @discounted_rate = 180
    @block = Hotel::Block.new(date_range: @date_range, rooms: rooms, discounted_rate: @discounted_rate)
  end
  describe "Initializer" do
    it "is an instance of Block" do
      expect(@block).must_be_kind_of Hotel::Block
    end
    it "raises exception for invalid number of rooms" do
      no_rooms = []
      expect { Hotel::Block.new(date_range: @date_range, rooms: no_rooms, discounted_rate: @discounted_rate) }.must_raise ArgumentError
    end
  end
end
