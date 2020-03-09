module Hotel
  class ReservationDesk
  # Class responsibility: to organize reservations across hotel
    attr_reader :room_num, :rooms, :reservations, :blocks

    def initialize(room_num: 20)
      @room_num = room_num
      @rooms = make_rooms
      @blocks = {}
    end

    def find_room_by_id(id)
      rooms.find {|room| room.id == id}
    end

    def find_reservations(room_id: nil , start_date: , end_date: )
      date_range = DateRange.new(start_date: start_date, end_date: end_date)

      if room_id 
        room = rooms.find { |room| room.id == room_id}
        return nil if room == nil
        reservations = room.select_reservations(date_range)
      else
        reservations = []
        rooms.each do |room|
          room_reservations = room.select_reservations(date_range)
          reservations += room_reservations
        end
      end
      return reservations
    end

    def find_available_rooms(start_date:, end_date:)
      available_rooms = []
      rooms.each do |room|
        available_rooms << room if room.available?(start_date: start_date, end_date: end_date)
      end
      return available_rooms.empty? ? nil : available_rooms
    end

    def make_reservation(room_id: nil, start_date:, end_date:, rate: :default)
      if room_id 
        room = find_room_by_id(room_id)
        raise ArgumentError.new("Invalid room ID.") if room == nil
      else
        room = find_available_rooms(start_date: start_date, end_date: end_date)[0]
        raise StandardError.new("No rooms available for these dates.") if room == nil
      end
      room.reserve(start_date: start_date, end_date: end_date, rate: rate)
    end

    def make_block(room_ids:, start_date:, end_date:, rate: :default)
      #TODO: add no rooms given scenario
      raise ArgumentError.new("Blocks should contain 2-5 rooms.") if (room_ids.length > 5 || room_ids.length < 2)

      block_id = create_block(start_date: start_date, end_date: end_date)
      room_ids.each do |id|
        room = find_room_by_id(id)
        raise ArgumentError.new("Invalid room ID.") if room == nil
        room.reserve(start_date: start_date, end_date: end_date, block: block_id, rate: rate)
        blocks[block_id][:rooms] << room
      end
    end

    def reserve_from_block(room_id: , block_id: )
      raise ArgumentError.new("Invalid block ID.") unless blocks[block_id]
      
      blocks[block_id][:rooms].each do |room|
        if room.id == room_id
          start_date = blocks[block_id][:date_range][0]
          end_date = blocks[block_id][:date_range][1] 
          unless room.reserved?(start_date: start_date, end_date: end_date)
            room.block_participation.each do |block_part|
              if block_part.date_range.start_date == Date.parse(start_date)
                room.reservations << block_part
                return true
              end
            end
          end
          raise StandardError.new("This room has already been reserved.")
        end
      end
      raise ArgumentError.new("Invalid room ID.")
    end

    def check_block_availability(block_id)
      raise ArgumentError.new("Invalid block ID.") unless blocks[block_id]
      available_rooms = []
      start_date = blocks[block_id][:date_range][0]
      end_date = blocks[block_id][:date_range][1]

      blocks[block_id][:rooms].each do |room|
        available_rooms << room unless room.reserved?(start_date: start_date, end_date: end_date)
      end
      return available_rooms
    end
    
    private
    def make_rooms
      rooms = []
      room_num.times do |i|
        rooms << Room.new(i+1)
      end
      return rooms
    end

    def generate_block_id
      blocks.length + 1
    end

    def create_block(start_date:, end_date:)
      block_id = generate_block_id
      blocks[block_id] = {}
      blocks[block_id][:date_range] = [start_date, end_date]
      blocks[block_id][:rooms] = []
      return block_id
    end
  end
end