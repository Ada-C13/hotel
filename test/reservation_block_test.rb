require_relative 'test_helper'

describe "initialize block" do
  date_range = Hotel::DateRange.new((Date.today), (Date.today + 1))
  
  let (:block) {
    Hotel::Block.new(date_range, 150, rooms: ["2", "3", "4", "5"])
  }
  
  it 'block properties' do
    expect(block).must_be_instance_of Hotel::Block
    expect(block.date_range).must_equal date_range
    expect(block.rooms).must_be_instance_of Array
    expect(block.discount_rate).must_equal 150
    expect(block.total_block_cost).must_equal 150
  end
  
end

describe "validate rooms" do
  date_range = Hotel::DateRange.new((Date.today), (Date.today + 1))
  
  let (:block) {
    Hotel::Block.new(date_range, 150, rooms: ["2", "3"])
  }
  
  it 'raises an argument error if a block is less than 2 or more than 5 rooms' do
    block.rooms = ["2", "3", "4", "5", "6", "7"]
    expect{ block.validate_rooms }.must_raise ArgumentError
  end
  
  it 'is silent for rooms between 2 & 5' do
    block.rooms = ["3", "4"]
    expect{ block.validate_rooms }.must_be_silent
  end
  
end

describe "total block cost" do
  
  it 'calculates cost for one night correctly' do
    date_range1 = Hotel::DateRange.new((Date.today),(Date.today + 1))
    
    block = Hotel::Block.new(date_range1, 150, rooms: ["2", "3", "4", "5"])
    
    expect(block.total_block_cost).must_equal 150
  end
  
  
  it 'calculates multi-night costs correctly' do
    date_range2 = Hotel::DateRange.new((Date.today),(Date.today + 2))
    
    block = Hotel::Block.new(date_range2, 150, rooms:["2", "3", "4", "5"])
    
    expect(block.total_block_cost).must_equal 300
  end
  
end
