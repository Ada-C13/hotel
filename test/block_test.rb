require_relative 'test_helper'

describe 'Block class' do
  before do 
    @arrive = Date.new(2021, 2, 24)
    @depart = Date.new(2021, 2, 26)
    @rate = 150
    @three_rooms = 3
    @new_block = Hotel::Block.new(@arrive, @depart, @rate, @three_rooms)
  end

  describe 'Block makes a new instance of block class' do
    it 'must make a new block' do
      expect(Hotel::Block.new(@arrive, @depart, @rate, @three_rooms)).must_be_instance_of Hotel::Block
      expect(@new_block.date_range).must_be_instance_of Hotel::DateRange
      expect(@new_block.date_range.arrive).must_equal @arrive
      expect(@new_block.date_range.depart).must_equal @depart
      expect(@new_block.rate).must_equal @rate
      expect(@new_block.num_of_rooms).must_equal @three_rooms
    end
  end

  describe 'Block make_id method' do
    it 'Block creates a unique 4 digit ID' do
      #TODO change this to equal a range of 1111-9999 
      expect(@new_block.make_id).must_equal 1234
    end
  end
end