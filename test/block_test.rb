require_relative 'test_helper'

describe Hotel::Block do
  before do
    @date_range = Hotel::DateRange.new(Date.today + 5, Date.today + 10)
    @roomid01 = 1
    @roomid02 = 2
  end

  describe "#initialize" do
    it "creates an instance of a Block class" do
      block01 = Hotel::Block.new(@date_range, @roomid01)
      expect(block01).must_be_instance_of Hotel::Block
    end

    it "stores the correct room_id in the reservation" do
      block01 = Hotel::Block.new(@date_range, @roomid01)
      expect(block01.room_id).must_be_instance_of Integer
      expect(block01.room_id).must_equal @roomid01
    end

    it "stores a date_range that is an instance of DateRange" do
      block01 = Hotel::Block.new(@date_range, @roomid01)
      expect(block01.date_range).must_be_instance_of Hotel::DateRange
    end

    it "stores start_date and end_date that are both an instance of Date" do
      block01 = Hotel::Block.new(@date_range, @roomid01)
      expect(block01.date_range.start_date).must_be_instance_of Date
      expect(block01.date_range.end_date).must_be_instance_of Date
    end

    it "shares the same block id for multiple rooms within the block" do
      block01 = Hotel::Block.new(@date_range, @roomid01, 100, 10)
      block02 = Hotel::Block.new(@date_range, @roomid02, 100, 10)
      expect(block01.block).must_equal 10
      expect(block02.block).must_equal 10
    end

    it "stores an attribute @cost that reflects the correct cost" do
      block01 = Hotel::Block.new(@date_range, @roomid01, 200,10)
      expect(block01.cost).must_equal 200.00
      block02 = Hotel::Block.new(@date_range, @roomid02, 100, 11)
      expect(block02.cost).must_equal 100.00
    end
  end

  describe "#get_total_price" do
    it "returns the total price for the reservation" do
      block01 = Hotel::Block.new(@date_range, @roomid01)
      expect(block01.get_total_price).must_equal 1000.00
      block02 = Hotel::Block.new(@date_range, @roomid02, 100)
      expect(block02.get_total_price).must_equal 500.00
    end
  end
end