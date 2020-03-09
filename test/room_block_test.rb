require_relative "test_helper"

describe "RoomBlock" do
  # Arrange
  describe "initialize" do
    # Act
    it "Create instance of RoomBlock" do
      block = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50)
      # Assert
      expect(block).must_be_kind_of Hotel::RoomBlock
    end
    # Act
    it "Name tracker" do
      block = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50)
      # Assert
      expect(block).must_respond_to :name
      expect(block.name).must_equal "Anaya"
    end
    # Act
    it "start_date tracker" do
      block = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50)
      # Assert
      expect(block).must_respond_to :start_date
      expect(block.start_date).must_equal Date.parse("March 3, 2020")
    end
    # Act
    it "end_date tracker" do
      block = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50)
      # Assert
      expect(block).must_respond_to :end_date
      expect(block.end_date).must_equal Date.parse("March 5, 2020")
    end
    # Act
    it "Keep track of discount" do
      block = Hotel::RoomBlock.new("Anaya", "March 3, 2020", "March 5, 2020", 50)
      # Assert
      expect(block).must_respond_to :discount
      expect(block.discount).must_equal 0.50
    end
  end
end