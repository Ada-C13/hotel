require_relative 'test_helper'

describe 'Block class' do
  before do 
    @arrive = Date.new(2021, 2, 24)
    @depart = Date.new(2021, 2, 26)
    @rate = 150
    @new_block = Hotel::Block.new(@arrive, @depart, @rate)
  end

  describe 'Block makes a new instance of block class' do
    it 'must make a new block' do
      expect(Hotel::Block.new(@arrive, @depart, @rate)).must_be_instance_of Hotel::Block
      expect(@new_block.arrive).must_equal @arrive
      expect(@new_block.depart).must_equal @depart
      expect(@new_block.rate).must_equal @rate
    end
  end

  describe 'given a range of dates determine if x amount of rooms can be booked' do 
  end

  describe 'blocks should be viewed with other reservatiosn' do 
  end
end