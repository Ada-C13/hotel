require_relative "test_helper.rb"

describe "ReservationManager class" do
   before do
      @phillip = Stayappy::ReservationManager.new()
   end
   
   describe "initialize method" do 
      it "can create an instance of ReservationManager" do
         expect(@phillip).must_be_instance_of Stayappy::ReservationManager 
      end

      it "creates 20 rooms" do
         expect(@phillip.rooms).must_be_instance_of Array
         expect(@phillip.rooms.length).must_equal 20
      end

      it "creates an empty list of bookings" do
         expect(@phillip.bookings).must_be_instance_of Array
         expect(@phillip.bookings.length).must_equal 0
      end
   end
   
   describe "make_reservation method" do 
      before do
         @check_in = Date.new(2020, 3, 10)
         @check_out = Date.new(2020, 3, 11)
      end

      it "can make a single reservation" do
         reservation = @phillip.make_reservation(@check_in, @check_out)

         expect(reservation).must_be_instance_of Stayappy::Reservation
         expect(reservation.room).must_be_instance_of Stayappy::Room
         expect(reservation.check_in).must_equal @check_in
         expect(reservation.check_out).must_equal @check_out
         expect(@phillip.bookings.length).must_equal 1
      end

      it "raises an exception if there are no available rooms for the date" do
         20.times do
            @phillip.make_reservation(@check_in, @check_out)
         end

         expect{ @phillip.make_reservation(@check_in, @check_out) }.must_raise ArgumentError
      end

   end
end 
