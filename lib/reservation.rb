
module Hotel
  class Reservation
    attr_reader :id

    def initialize(id:, room:, start_date:, end_date:)
      @id = id
    end
  end
  
end