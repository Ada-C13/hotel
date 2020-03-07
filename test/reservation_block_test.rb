require_relative 'test_helper'

describe "initialize block" do
  date_range = Hotel::DateRange.new((Date.today), (Date.today + 1))
  
  let (:block) {
    Hotel::Block.new(date_range, rooms = ["2", "3", "4", "5"], 150)
  }
  
  it 'block properties' do
    expect(block).must_be_instance_of Hotel::Block
    expect(block.date_range).must_equal date_range
    expect(block.rooms).must_be_instance_of Array
    expect(block.discount_rate).must_equal 150
    expect(block.total_block_cost).must_equal 150
  end
  
end

describe "total block cost" do
  
  it 'calculates cost for one night correctly' do
    date_range1 = Hotel::DateRange.new((Date.today),(Date.today + 1))
    
    block = Hotel::Block.new(date_range1, rooms = ["2", "3", "4", "5"], 150)
    
    expect(block.total_block_cost).must_equal 150
  end
  
  
  it 'calculates multi-night costs correctly' do
    date_range2 = Hotel::DateRange.new((Date.today),(Date.today + 2))
    
    block = Hotel::Block.new(date_range2, rooms = ["2", "3", "4", "5"], 150)
    
    expect(block.total_block_cost).must_equal 300
  end
  
end