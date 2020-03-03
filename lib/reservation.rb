require 'awesome_print'
require 'date'
require 'csv'

module Hotel
    class Reservation
        attr_reader :reservation_id, :check_in, :check_out, :number_of_days
        attr_accessor :status, :room_id
        VALID_STATUS = [:pending, :denied, :confirmed]

        def initialize(reservation_id, check_in, number_of_days, status = :pending, room_id = nil)
            @reservation_id = reservation_id
            @check_in = check_in
            @number_of_days = number_of_days
            @status = status
            @room_id = room_id

            @check_out = check_in + number_of_days
        end

        def self.load_all_reservations () #what to get
            reservations = CSV.parse(File.read(__dir__ + "/../support/reservations.csv"), headers: true, header_converters: :symbol,) #relative to HOTEL & reading csv file
            all_reservations = [] #save all rooms to this array
              reservations.each do |record| #loop through each record in reservations csv
                reservation_id = record[:reservation_id]
                check_in = Date.parse(record[:check_in])
                number_of_days = record[:number_of_days].to_i
                status = record[:status].to_sym
                room_id = record[:room_id]
                temp_reservation = Reservation.new(reservation_id, check_in, number_of_days, status, room_id)
                all_reservations.push(temp_reservation) #push Room into all_rooms
              end
          return all_reservations #return all the rooms
          end

    end
end

# date = Date.parse("10/10/2020")
#  date = Date.parse("2020-02-01")
#  puts date
# test = Hotel::Reservation.new(1, date, 30, "confirmed", 1)

# puts test.reservation_id
# puts test.check_in
# puts test.number_of_days
# puts test.status
# puts test.room_id
# puts test.check_out

# test = Hotel::Reservation.new(1, date, 10)

# puts test.reservation_id
# puts test.check_in
# puts test.number_of_days
# puts test.status
# puts test.room_id
# puts test.check_out
# Hotel::Reservation.load_all_reservations.each do |res|
#     puts res.reservation_id
#     puts res.status
# end


