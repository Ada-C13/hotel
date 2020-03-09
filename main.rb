#!/usr/bin/ruby
# 
# Title  : Hotel Main - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : March 2020
# 
require "Date"
require_relative "lib/date_range"
require_relative "lib/reservation"
require_relative "lib/block"
require_relative "lib/hotel_controller"

DISCOUNT_RATE = 150

# Function to prompt for a date
def get_date(message)
  valid_date = false
  while !valid_date
    print message
    begin
      date = Date.parse(gets.chomp)
      valid_date = true
    rescue => exception
      puts "Error: #{exception.message}"
    end
  end
  return date
end

# Function to prompt for a positive integer with min, max
def get_integer(prompt, min, max)
  expression = /[0-9]+/
  # Repeat until number within range
  number = 0             
  input  = ""             
  while number < min || number > max || input == ""
    # Repeat until valid number
    input = ""
    while input.match(expression).to_s != input || input == "" 
      print prompt
      input = gets.chomp
      puts "This is not a valid number!" if input.match(expression).to_s != input || input == ""
    end
    number = input.to_i
    puts "Number is too large. Maximum is #{max}." if number > max
    puts "Number is too small. Minimum is #{min}." if number < min
  end
  return number
end

# Reserve a room
def make_reservation(hotel)
  puts "Enter the data for the new reservation"
  start_date = get_date("Start date: ")
  end_date   = get_date("End date: ")
  print "\nDo you confirm you want to add this reservation? (Y/N) "
  confirm = gets.chomp.upcase
  if confirm == "Y" || confirm == "YES"
    begin
      reservation = hotel.reserve_room(start_date, end_date)
      puts "New reservation was made for room #{reservation.room}."
    rescue => exception
      puts "Error: #{exception.message}"
    end
  else 
    puts "Ok, new reservation was NOT made."
  end
end

# Make a block
def make_block(hotel)
  puts "Enter the data for the new block"
  start_date = get_date("Start date: ")
  end_date   = get_date("End date: ")
  start_room = get_integer("Start room: ", 1, 20)
  end_room   = get_integer("End room: ", start_room, 20)
  print "\nDo you confirm you want to add this block? (Y/N) "
  confirm = gets.chomp.upcase
  if confirm == "Y" || confirm == "YES"
    begin
      block = hotel.create_block(start_date, end_date, (start_room..end_room).to_a, DISCOUNT_RATE)
      puts "New block was made."
    rescue => exception
      puts "Error: #{exception.message}"
    end
  else 
    puts "Ok, new block was NOT made."
  end
end

# Make a new reservation from the block
def make_block_reservation(hotel)
  show_blocks(hotel)
  return if hotel.blocks.size == 0
  puts "\nEnter the data for the block reservation."
  start_date = get_date("Start date: ")
  end_date   = get_date("End date: ")
  room       = get_integer("Room to reserve: ", 1, 20)
  begin
    block = hotel.blocks_by_room(start_date, end_date, room).first
  rescue  => exception
    puts "Error: #{exception.message}"
    block = nil
  end
  if block == nil
    puts "\nCould not find that block."
  else
    begin
      hotel.reserve_from_block(block, room)
    rescue => exception
      puts "Error: #{exception.message}"
    end
  end
end

# Show reservations
def show_reservations(hotel)
  puts "List of reservations\n\n"
  puts "No reservations!" if hotel.reservations.size == 0
  hotel.reservations.each do |reservation|
    puts "Start date: #{reservation.range.start_date}, end date: #{reservation.range.end_date}, room: #{reservation.room}"
  end
end

# Show blocks
def show_blocks(hotel)
  puts "List of blocks\n\n"
  puts "No blocks!" if hotel.blocks.size == 0
  hotel.blocks.each do |block|
    print "Start date: #{block.range.start_date}, end date: #{block.range.end_date}, rooms:"
    block.rooms.each do |room|
      print " #{room}"
    end
    print ", available rooms:"
    available = hotel.available_rooms_in(block)
    available.each do |room|
      print " #{room}"
    end
    print "None" if available.size == 0
    puts 
  end
end

# Main method to show CLI options and call other methods
def main
  hotel = Hotel::HotelController.new

  puts "\nWelcome to Hotel Ada Lovelace!"
  choice = ""
  while choice != "exit"
    puts "\nHotel Main Menu:"
    puts "1 - Make Reservation (mr, r)"
    puts "2 - Make Block (mb, b)" 
    puts "3 - Make Block Reservation (mbr, br)"
    puts "4 - Show Reservations (sr, s)"
    puts "5 - Show Blocks (sb)"
    puts "6 - Exit (x, q)"
    print "\nWhat would you like to do? "
    choice = gets.chomp.downcase
    case choice
      when "make reservation", "reservation", "mr", "r", "1"
        make_reservation(hotel)
      when "make block", "block", "mb", "b", "2"
        make_block(hotel)
      when "make block reservation", "mbr", "br", "3"
        make_block_reservation(hotel)
      when "show reservations", "sr", "s", "4"
        show_reservations(hotel)
      when "show blocks", "sb", "5"
        show_blocks(hotel)
      when "exit", "x", "quit", "q", "e", "6"
        choice = "exit"
      else
       puts "Invalid choice!"
    end
  end
end

main