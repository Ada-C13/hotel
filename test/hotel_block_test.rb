require_relative "test_helper"

describe "Instanitates a new Hotel Block" do
  let(:room_ids) { 5 }
  let(:room_info) { 5 }
  let(:hotel_block_id) { 101 }
  let(:room_rate) { 150 }
  let(:check_in_date) { Date.new(2001, 2, 1) }
  let(:check_out_date) { Date.new(2001, 2, 3) }

  it "Initialize Hotel Block" do
    room_ids = [1, 2, 3, 4, 5]
    new_hotel_block = Hotel_Block.new(room_ids, check_in_date, check_out_date, room_rate, hotel_block_id)
    expect(new_hotel_block).must_be_kind_of Hotel_Block
  end

  it "Correctly show Check room availablity as occupied" do
    room_ids = [1, 2, 3, 4, 5]
    new_hotel_block = Hotel_Block.new(room_ids, check_in_date, check_out_date, room_rate, hotel_block_id)
    expect(new_hotel_block.check_rooms_available).must_equal true
  end

  it "Correctly show Check room availablity as occupied" do
    room_ids = [1, 2, 3, 4, 5]
    new_hotel_block = Hotel_Block.new(room_ids, check_in_date, check_out_date, room_rate, hotel_block_id)
    new_hotel_block.room_info = {1=> true,2=> true,3=> true,4=> true,5=> true}
    expect(new_hotel_block.check_rooms_available).must_equal false
  end
end
