require 'awesome_print'
require 'date'
require 'csv'
require_relative 'room'

module Hotel
    class Reservation
      attr_reader :reservation_id, :check_in, :check_out, :number_of_days
      attr_accessor :status, :room_number, :room
      VALID_STATUS = [:pending, :denied, :confirmed]

      def initialize(reservation_id, check_in, number_of_days, status = :pending, room = nil, room_number = nil)
        @reservation_id = reservation_id
        
        if check_in.class != Date
          raise ArgumentError.new("Invaid, check-in date must be Date.")
        end
        @check_in = check_in


        if number_of_days <= 0
          raise ArgumentError.new("Invalid, number of days must be greater than 0")
        end
        @number_of_days = number_of_days
        
        @status = status
        @check_out = check_in + number_of_days 

        if room
          @room = room
          @room_number = room.room_number
        else
          @room = room
          @room_number = room_number
        end
        
      end #initialize
  #****************************************************************

      #Total cost for a given reservation
      #returns total_cost (float)
      def total_cost()
        total_cost = nil
        if @room != nil
          total_cost = @room.price.to_f * @number_of_days
        end
        return total_cost
      end  
  #****************************************************************

      # checks if aDate is within the check_in and check_out
      # aDate (Date)
      # returns true or false 
      def is_within_stay(aDate)
        if (aDate >= @check_in) && (aDate < @check_out)
          return true
        end
        return false
      end
      #****************************************************************
      #Helper method to def are_reservations_overlapped(aReservations)
      #Checks if this reservation (self) overlaps, with aReservation passed in
      #input: aReservation (Reservation)
      #return: isOverlapped (boolean)
      def is_overlapped(aReservation)
        is_overlapped = true
        #check self reservation overlaps with aReservation
        if (self.check_out <= aReservation.check_in) || (self.check_in >= aReservation.check_out)
          is_overlapped = false
        else 
          is_overlapped = true
        end
        return is_overlapped
      end
      #****************************************************************

      #Checks if this reservation (self) overlaps, with reservations passed in
      #input: aReservations ([Reservations])
      #return: isOverlapped (boolean)
      def are_reservations_overlapped(aReservations)
        are_overlapped = false
        #loop through aReservations
        aReservations.each do |reservation|
        #check if self reservation overlaps with reservation in loop
          if self.is_overlapped(reservation)
            return true
          end
        end
        return are_overlapped
      end

      #****************************************************************

      def self.load_all_reservations() #what to get
        reservations = CSV.parse(File.read(__dir__ + "/../support/reservations.csv"), headers: true, header_converters: :symbol) #relative to HOTEL & reading csv file
        all_reservations = [] #save all rooms to this array
        reservations.each do |record| #loop through each record in reservations csv
          reservation_id = record[:reservation_id].to_i
          check_in = Date.parse(record[:check_in])
          number_of_days = record[:number_of_days].to_i
          status = record[:status].to_sym
          room_number = record[:room_number].to_i

          temp_reservation = Reservation.new(reservation_id, check_in, number_of_days, status,nil, room_number)
          all_reservations.push(temp_reservation) #push Room into all_rooms
        end
        return all_reservations #return all the rooms
      end
      #****************************************************************
    end #class
end #module




# date = Date.parse("2020-02-01")
# puts date

# res = Hotel::Reservation.new(1, date, 7, "confirmed")
# puts res.is_within_stay(Date.parse("2020-02-01"))

# puts res.total_cost
# puts test.reservation_id
# puts test.check_in
# puts test.number_of_days
# puts test.status
# puts test.room_number
# puts test.check_out

# test = Hotel::Reservation.new(1, date, 10)

# puts test.reservation_id
# puts test.check_in
# puts test.number_of_days
# puts test.status
# puts test.room_number
# puts test.check_out
# Hotel::Reservation.load_all_reservations.each do |res|
#     puts res.reservation_id
#     puts res.status
# end
# date1 = Date.parse("2020-01-10")
# res1 = Hotel::Reservation.new(1, date1, 20, "confirmed", room)
# puts "New Res: #{res1.check_in} - #{res1.check_out}"

# date2 = Date.parse("2020-01-05")
# res2 = Hotel::Reservation.new(2, date2, 5, "confirmed", room)
# puts "Res2: #{res2.check_in} - #{res2.check_out}"

# date3 = Date.parse("2020-01-20")
# res3 = Hotel::Reservation.new(2, date3, 5, "confirmed", room)
# puts "Res3: #{res3.check_in} - #{res3.check_out}"

# res_array = [res2, res3]

# # puts res1.is_overlapped(res2)
# puts res1.are_reservations_overlapped(res_array)
