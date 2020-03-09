require_relative "test_helper.rb"

describe "BlockRes class" do
  before do
    block = []

    5.times do |room_num|
      room = Stayappy::Room.new(room_num: room_num, cost: 175.00)
    block << room
    end 

    @soroptomists = Stayappy::BlockRes.new(block, Date.new(2020, 6, 17), Date.new(2020, 6, 20), 175.00)
  end

  describe "initialize method" do
    it "can create an instance of BlockRes" do
      expect(@soroptomists).must_be_instance_of Stayappy::BlockRes
      expect(@soroptomists.discounted_rate).must_equal 175.00
    end

    it "raises error if anything greater than five is entered as the block argument" do
      block = []

      10.times do |room_num|
        room = Stayappy::Room.new(room_num: room_num, cost: 175.00)
        block << room
      end 

      expect { Stayappy::BlockRes.new(block, Date.new(2020, 3,12), Date.new(2020, 3, 15), 175.00) }.must_raise ArgumentError
    end
  end
end