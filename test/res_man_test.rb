require_relative 'test_helper.rb'

describe "Reservation class" do
  describe "Init" do 
    before do
      @reservation = Stayappy::Reservation.new(
      check_in: date.new(2020, 3, 10),
      check_out: date.new(2020, 3, 14),
      res_num: 987654321, 
      room_num: 10, 
      total: 600.00
      )
    end 

    it "is an instance of reservation" do
     expect(@reservation).must_be_kind_of Stayappy::Reservation 
    end 

  end 
end