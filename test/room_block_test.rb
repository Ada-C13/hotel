require_relative "test_helper"

describe "RoomBlock" do
  let (:block_room_1) { Hotel::Room.new(1) }
  let (:block_room_2) { Hotel::Room.new(2) }
  let (:block_room_3) { Hotel::Room.new(3) }
  let (:block_room_4) { Hotel::Room.new(4) }
  let (:block_room_5) { Hotel::Room.new(5) }
  let (:block) { Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 3,[block_room_1, block_room_2, block_room_3]) }
  # Arrange
  describe "initialize" do  
  # Act
    it "Create instance of RoomBlock" do
      # Assert
      expect(block).must_be_kind_of Hotel::RoomBlock
    end
    # Act
    it "Name tracker" do
      # Assert
      expect(block).must_respond_to :name
      expect(block.name).must_equal "Anaya"
    end
    # Act
    it "start_date tracker" do
      # Assert
      expect(block).must_respond_to :start_date
      expect(block.start_date).must_equal Date.parse("March 3, 2020")
    end
    # Act
    it "end_date tracker" do
      # Assert
      expect(block).must_respond_to :end_date
      expect(block.end_date).must_equal Date.parse("March 5, 2020")
    end
    # Act
    it "discount tracker" do
      # Assert
      expect(block).must_respond_to :discount
      expect(block.discount).must_equal 0.50
    end
    # Act
    it "how_many_rooms' tracker" do
      # Assert
      expect(block).must_respond_to :how_many_rooms
      expect(block.how_many_rooms).must_equal 3
    end
    # Act
    it "1 - 5 rooms allowed per block" do
      block_a = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 1, [block_room_1])
      block_b = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 5, [block_room_1, block_room_2, block_room_3, block_room_4, block_room_5])
      # Assert
      expect(block_a.how_many_rooms).must_equal 1
      expect(block_b.how_many_rooms).must_equal 5
    end
    # Act
    it "Raise error for blocks of rooms that don't meet requirements" do
      # Assert
      expect { Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 0, [block_room_1]) }.must_raise StandardError
      expect { Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 6, [block_room_1]) }.must_raise StandardError
    end
    # Act
    it "list_rooms' tracker" do
      # Assert
      expect(block).must_respond_to :list_rooms
      expect(block.list_rooms).must_be_kind_of Array
      expect(block.list_rooms.include?(block_room_1)).must_equal true
      expect(block.list_rooms.include?(block_room_2)).must_equal true
      expect(block.list_rooms.include?(block_room_3)).must_equal true
    end
    # Act
    it "reservations' tracker" do
      # Assert
      expect(block).must_respond_to :reservations
      expect(block.reservations).must_be_kind_of Array
    end
  end
end