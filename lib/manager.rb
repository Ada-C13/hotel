require 'time'
require 'date'
require_relative 'room'
require_relative 'reservation'


module Hotel
  class Manager
    attr_reader :num
    attr_writer
    attr_accessor

    def initialize
      @all_rooms = Manager.create_rooms(20)
      return @all_rooms
    end

    def self.create_rooms(num)
      all_rooms = []
      i = 1
      num.times do 
        all_rooms << Room.new(rm_num: i)
        i + 1
      end
      return all_rooms
    end

    def book_res(start_date, end_date)
      @reservation = Reservation.new(start_date: start_date, end_date: end_date)
      # run availablity check in res
      # once res is complete @reservation.push(all_res per room)
      # @rm_reservations = []
    end

  end
end


