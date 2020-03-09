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
         @phillip.rooms.each do |room| 
            expect(room).must_be_instance_of Stayappy::Room
         end
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

      it "can book a room when someone else is checking out that day" do
         reservations = []
         reservations << @phillip.make_reservation(@check_in, @check_out)
         reservations << @phillip.make_reservation(@check_out, @check_out + 1)
         
         reservations.each do |reservation|
            expect(reservation.room.room_num).must_equal 1
         end
      end
   end

   describe "reservations_by_room method" do
      before do
         @room_num = 1
         @start_date = Date.new(2020, 5, 30)
         @end_date = Date.new(2020, 5, 31)
         @reservation = @phillip.make_reservation(
            @start_date, 
            @end_date
         )
      end

      it "finds reservation with room number match" do
         matching_reservations = @phillip.reservations_by_room(
            @room_num,
            @start_date,
            @end_date
         )
         expect(matching_reservations.length).must_equal 1
         expect(matching_reservations[0]).must_equal @reservation
         expect(matching_reservations[0].room.room_num).must_equal @room_num
      end

      it "finds no reservation if no room number match" do
         matching_reservations = @phillip.reservations_by_room(
            999,
            @start_date,
            @end_date
         )
         expect(matching_reservations.length).must_equal 0
      end

      it "finds no reservation if no date match" do
         matching_reservations = @phillip.reservations_by_room(
            @room_num,
            Date.new(2019, 03, 10),
            Date.new(2019, 03, 20),
         )
         expect(matching_reservations.length).must_equal 0
      end
   end

   describe "reservations_by_date method" do
      before do
         @check_in = Date.new(2020, 3, 10)
         @check_out = Date.new(2020, 3, 11)
         @reservation = @phillip.make_reservation(
            @check_in, 
            @check_out
         )
      end

      it "can retrieve a reservation given a valid date" do
         matching_reservations = @phillip.reservations_by_date(@check_in)
         
         expect(matching_reservations.length).must_equal 1
         expect(matching_reservations[0]).must_equal @reservation
      end

      it "will not retrieve any reservations for a non-matching date" do
         matching_reservations = @phillip.reservations_by_date(
            Date.new(2019, 03, 20)
         )
         
         expect(matching_reservations.length).must_equal 0
      end
   end 

   describe "view_by_vacancy method" do
      it "retrieves all rooms for a range with no bookings" do
         check_in = Date.new(2020, 05, 1)
         check_out = Date.new(2020, 05, 1)

         vacancies = @phillip.view_by_vacancy(check_in, check_out)

         expect(vacancies.length).must_equal 20
         vacancies.each do |room|
            expect(room).must_be_instance_of Stayappy::Room
         end
      end

      it "excludes a reserved room when a booking is matched" do
         @check_in = Date.new(2020, 3, 10)
         @check_out = Date.new(2020, 3, 11)
         @reservation = @phillip.make_reservation(
            @check_in, 
            @check_out
         )

         vacancies = @phillip.view_by_vacancy(@check_in, @check_out)

         expect(vacancies.length).must_equal 19
         vacancies.each do |room|
            expect(room.room_num).wont_equal @reservation.room.room_num
         end
      end

      it "returns no rooms when hotel is fully booked" do
         @check_in = Date.new(2020, 3, 10)
         @check_out = Date.new(2020, 3, 11)
         20.times do
            @phillip.make_reservation(
               @check_in, 
               @check_out
            )
         end

         vacancies = @phillip.view_by_vacancy(@check_in, @check_out)

         expect(vacancies.length).must_equal 0
      end
   end
end 
