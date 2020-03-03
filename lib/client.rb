
module Hotel
  class Client
    attr_reader :id, :name, :phone_number
    
    def initialize(id, name, phone_number) 
      @id = id
      @name = name
      @phone_number = phone_number
    end
  end
end