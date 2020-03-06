require_relative "test_helper"

describe Hotel::Block do
  before do
    @hotel_controller = Hotel::HotelController.new
    @date = Date.parse("2020-08-04")
  end

  describe "consructor" do

    it "Can be initialized " do
      date_range = DateRange.new(@date,(@date + 3))
      collection_of_rooms = [1,2,3,4,5]
      discount_rate = 150

      expect(Block.new(date_range, collection_of_rooms, discount_rate, @hotel_controller)).must_be_instance_of Block
    end
   
    it "Will raise error if one room in block is unavailable " do
      reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",1)

      date_range = DateRange.new(@date,(@date + 3))
      collection_of_rooms = [1,2,3,4,5]
      discount_rate = 150
      
      expect{Block.new(date_range, collection_of_rooms, discount_rate, @hotel_controller)}.must_raise ArgumentError
    end
    it "Will raise error if more than one room is unavailable " do
      reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",3)
      reservation1 = @hotel_controller.reserve_room("2020-08-04", "2020-08-10",5)

      date_range = DateRange.new(@date,(@date + 3))
      collection_of_rooms = [1,2,3,4,5]
      discount_rate = 150
      
      expect{Block.new(date_range, collection_of_rooms, discount_rate, @hotel_controller)}.must_raise ArgumentError
    end
    it "Will pass if date_range starts on a reservation end date " do
      reservation1 = @hotel_controller.reserve_room("2020-08-01", "2020-08-04",3) #other reservation end on the 4th

      date_range = DateRange.new(@date,(@date + 3))
      collection_of_rooms = [1,2,3,4,5]
      discount_rate = 150
      
      expect(Block.new(date_range, collection_of_rooms, discount_rate, @hotel_controller)).must_be_instance_of Block
    end
 
  end

  xdescribe "" do
    

    it " " do
      
    end

    xit " " do
    end

    
  end

  xdescribe " " do
    it " " do
      
    end
  end
end