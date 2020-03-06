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
        @check_in = check_in
        @number_of_days = number_of_days
        @status = status
        @check_out = check_in + number_of_days

        if room
          @room = room
          @room_number = room.room_number
        elsif room_number
          @room_number = room_number
        else
          raise ArgumentError, 'Room or room_number is required'
        end

        if number_of_days < 0
            raise ArgumentError.new("Invalid, number of days must be greater than 0")
        end
      end #initialize
  #****************************************************************

      #Total cost for a given reservation
      #returns total_cost (float)
      def total_cost()
        #TODO check if room exists
        total_cost = @room.price.to_f * @number_of_days
        return total_cost
      end  
  #****************************************************************

      #list of reservations for a specific date
      def get_reservations(date) 
        list_of_reservations_date = []
        @reservations.each do |reservation|
          if check_in == reservation.check_in
            list_of_reservations_date.push(reservation)   
          end
        end
        return list_of_reservations_date
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

      def self.load_all_reservations() #what to get
        reservations = CSV.parse(File.read(__dir__ + "/../support/reservations.csv"), headers: true, header_converters: :symbol) #relative to HOTEL & reading csv file
        all_reservations = [] #save all rooms to this array
        reservations.each do |record| #loop through each record in reservations csv
          reservation_id = record[:reservation_id]
          check_in = Date.parse(record[:check_in])
          number_of_days = record[:number_of_days].to_i
          status = record[:status].to_sym
          room_number = record[:room_number]

          temp_reservation = Reservation.new(reservation_id, check_in, number_of_days, status,nil, room_number)
          all_reservations.push(temp_reservation) #push Room into all_rooms
        end
        return all_reservations #return all the rooms
      end
  #****************************************************************

          # #valid date
    # def validate_date(date)
    #   if date.class == String
    #     date = Date.parse(date)
    #   elsif date.class != Date
    #     raise ArgumentError.new("You entered #{date}. Invalid, try again using this format '2020-03-04'")
    #   end
    #   return date
    # end

    # #validate stay
    # def validate_stay(check_in, number_of_days)
    #   check_in = validate_date(check_in)
    #   check_out = validate_date(check_out)
    #   if check_in > check_out
    #     raise ArgumentError.new("Invalid. This check-out date: #{check_out} is before the check-in date: #{check_in}")
    #   end
    # end

    end #class
end #module




date = Date.parse("2020-02-01")
# puts date
room = Hotel::Room.new("10A",200)
res = Hotel::Reservation.new(1, date, 7, "confirmed", room)
puts res.is_within_stay(Date.parse("2020-02-01"))

puts res.total_cost
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


