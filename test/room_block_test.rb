require_relative "test_helper"

describe "RoomBlock" do
  let (:room1) { Hotel::Room.new(1) }
  let (:room2) { Hotel::Room.new(2) }
  let (:room3) { Hotel::Room.new(3) }
  let (:room4) { Hotel::Room.new(4) }
  let (:room5) { Hotel::Room.new(5) }
  let (:block) { Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 3) }
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
    it "Keep track of discount" do
      # Assert
      expect(block).must_respond_to :discount
      expect(block.discount).must_equal 0.50
    end
    # Act
    it "Keep track of block_id" do
      # Assert
      expect(block).must_respond_to :block_id
      expect(block.block_id).must_equal 3
    end
    # Act
    it "1 - 5 rooms allowed per block" do
      block_a = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 1)
      block_b = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 5)
      # Assert
      expect(block_a.block_id).must_equal 1
      expect(block_b.block_id).must_equal 5
    end
    # Act
    it "Raise error for blocks of rooms that don't meet requirements" do
      # Assert
      expect { Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 0) }.must_raise ArgumentError
      expect { Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50, 6) }.must_raise ArgumentError
    end
  end
end