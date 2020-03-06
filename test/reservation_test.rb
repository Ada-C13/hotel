require_relative 'test_helper.rb'

describe "Reservation class" do
  describe "Init" do 
    before do
      @reservation = Stayappy::Reservation.new(
      check_in: Date.new(2020, 3, 10),
      check_out: Date.new(2020, 3, 14),
      res_num: 987654321, 
      room_num: 10, 
      total: 600.00
      )
    end 

    it "is an instance of reservation" do
     expect(@reservation).must_be_kind_of Stayappy::Reservation 
    end 
  end


  describe "date_vet data type tests" do
    before do
      @reservation = Stayappy::Reservation.new(
      check_in: Date.new(2020, 6, 10),
      check_out: Date.new(2020, 7, 10),
      res_num: 987654321, 
      room_num: 10, 
      total: 600.00
      )
    end 

    it "raises an error if check_in is not from the Date class" do
      expect(@check_in).must_be_kind_of Date
      end

    it "raises an error if check_out is not from the Date class" do
      expect(@check_out).must_be_kind_of Date
    end
  end


  describe "assign_room can bump reserved rooms out of AVAILABLE_ROOMS array test" do
    before do
      room_count = Stayappy::avail.count
    end

    it "verifies that AVAILABLE_ROOMS array decreases in length" do
      expect(Stayappy::AVAILABLE_ROOMS.count).must_equal room_count - 1
    end
  end


  describe "assign_room can raise error if the AVAILABLE_ROOMS array is empty" do
    before do
      Stayappy::available_rooms.clear
    end

    it "raises an error if there are no available rooms" do
      expect(Stayappy::AVAILABLE_ROOMS).must_equal []
    end
  end


  describe "book_of_bookings method tests" do
    it "book_of_bookings data type verification test" do
     expect(visit).must_be_kind_of Hash 
    end
  end 

  describe "BOOKINGS variable count" do
    before do
      pre_book = Stayappy::BOOKINGS.count
    end
    
    it "BOOKINGS variable count increases in length" do
      expect(Stayappy::BOOKINGS.count).must_equal pre_book + 1
    end
  end
end