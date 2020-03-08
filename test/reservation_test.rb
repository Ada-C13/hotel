require_relative 'test_helper.rb'

xdescribe "Reservation class" do

  describe "Initialize" do 
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
      expect(Stayappy::Reservation.check_in).must_be_kind_of Date.new
    end

    it "raises an error if check_out is not from the Date class" do
      expect(Stayappy::Reservation.check_out).must_be_kind_of Date.new
    end
  end

  describe "receipt" do
    before do
      @reservation = Stayappy::Reservation.new(
      check_in: Date.new(2020, 3, 10),
      check_out: Date.new(2020, 3, 14),
      res_num: 987654321, 
      room_num: 10, 
      total: 600.00
    )
    end

    it "sums the stay's total" do
      expect(@reservation.receipt).must_equal 600.00
    end

    it "expects that an error will be raised if sum incorrect" do
      expect(@reservation.receipt / 200.00).must_equal @reservation.stay.length -1
    end
  end
end