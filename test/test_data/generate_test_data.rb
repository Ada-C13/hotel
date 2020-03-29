require "csv"
require "securerandom"
require "date"

def write_reservation_csv
  reservations = [
    { id: SecureRandom.alphanumeric,
     start_date: Date.today + 190,
     end_date: Date.today + 197,
     room_qty: 1,
     cost: 200 * 7 },
    { id: SecureRandom.alphanumeric,
     start_date: Date.today + 110,
     end_date: Date.today + 117,
     room_qty: 1,
     cost: 200 * 7 },
    { id: SecureRandom.alphanumeric,
     start_date: Date.today + 210,
     end_date: Date.today + 217,
     room_qty: 1,
     cost: 200 * 6 },
    { id: SecureRandom.alphanumeric,
     start_date: Date.today + 217,
     end_date: Date.today + 219,
     room_qty: 1,
     cost: 200 * 2 },
    { id: SecureRandom.alphanumeric,
     start_date: Date.today + 217,
     end_date: Date.today + 219,
     room_qty: 1,
     cost: 200 * 2 },
  ]

  reservation_csv = CSV.open("test/test_data/reservation.csv", "w+",
                             write_headers: true,
                             headers: [:id, :start_date, :end_date, :room_qty, :cost])

  reservations.each do |reservation|
    reservation_csv << reservation
  end
end

def write_block_csv
  blocks = [
    {
      id: SecureRandom.alphanumeric,
      start_date: Date.today + 200,
      end_date: Date.today + 205,
      room_qty: 5,
      discount_rate: 0.8,
      cost: 200 * 0.8 * 5 * 5,
      available_rooms_qty: 5,
      reserved_rooms_qty: 0,
    },
  # {
  #   id: SecureRandom.alphanumeric,
  #   start_date: Date.today + 200,
  #   end_date: Date.today + 203,
  #   room_qty: 3,
  #   discount_rate: 0.8,
  #   cost: (200 * 0.8 * 3 * 3),
  #   available_rooms_qty: 0,
  #   reserved_rooms_qty: 3,
  # },
  # {
  #   id: SecureRandom.alphanumeric,
  #   start_date: Date.today + 200,
  #   end_date: Date.today + 203,
  #   room_qty: 3,
  #   discount_rate: 0.8,
  #   cost: (200 * 0.8 * 3 * 3),
  #   available_rooms_qty: 1,
  #   reserved_rooms_qty: 2,
  # },
  # {
  #   id: SecureRandom.alphanumeric,
  #   start_date: Date.today + 300,
  #   end_date: Date.today + 303,
  #   room_qty: 3,
  #   discount_rate: 0.5,
  #   cost: (200 * 0.5 * 3 * 3),
  #   available_rooms_qty: 2,
  #   reserved_rooms_qty: 1,
  # },
  # {
  #   id: SecureRandom.alphanumeric,
  #   start_date: Date.today + 300,
  #   end_date: Date.today + 306,
  #   room_qty: 2,
  #   discount_rate: 0.8,
  #   cost: (200 * 0.8 * 2 * 6),
  #   available_rooms_qty: 0,
  #   reserved_rooms_qty: 2,
  # },
  ]

  block_csv = CSV.open("test/test_data/block.csv", "w+",
                       write_headers: true,
                       headers: [:id, :start_date, :end_date, :room_qty, :discount_rate, :cost, :available_rooms_qty, :reserved_rooms_qty])

  blocks.each do |block|
    block_csv << block
  end
end

def write_room_csv
  rooms = []

  20.times do |i|
    rooms << {
      num: i + 1,
      cost: 200,
    }
  end

  room_csv = CSV.open("test/test_data/room.csv", "w+",
                      write_headers: true,
                      headers: [:num, :cost])

  rooms.each do |room|
    room_csv << room
  end
end

# TODO
# write_reservation_csv
# write_block_csv
write_room_csv
