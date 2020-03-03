require_relative 'test_helper'

describe "front desk" do
  describe "self.rooms" do
    
    before do
      @front_desk = Hotel::FrontDesk.new
    end

    it "stores all 20 hotel rooms" do
      expect(@front_desk.rooms.count).must_equal 20
    end

    it "returns an array of the 20 rooms" do
      expect(@front_desk.rooms).must_be_instance_of Array
    end

    it "stores instances of the Room class inside the array" do
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
      expect(@front_desk.rooms.sample).must_be_instance_of Hotel::Room
    end
  end

  # describe "self.find_room" do
  #   it "finds an instance of a room given the room number" do
  #     room_number = 4
  #     expect(Hotel::FrontDesk.find_room(room_number)).must_be_instance_of Hotel::Room
  #   end
  # end

  # describe "add_reservation" do
  #   it "" do
      
  #   end
  # end
end