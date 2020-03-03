require 'test_helper'
require 'date'

describe "Reservations class" do

  describe "Initializer" do
    it "is an instance of Reservations" do
        check_in = Date.today
        check_out = check_in + 3
      reservation = Hotel::Reservations.new(id: 423234 , date_in: check_in, date_out: check_out , room_id:324)
        expect(reservation).must_be_kind_of Hotel::Reservations
    end
    

  end  
end