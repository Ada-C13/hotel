module HotelBooking
  class Room
    attr_reader :number, :unavailable_dates
    def initialize(number:, cost: 200)
      @number = number
      # @reservations = []
      @unavailable_dates = []

      raise ArgumentError.new("That room number does not exist") if !((1..20).include? number)

    end

    def self.all
    end

    # def self.all
    #   all_orders = []
    #   filename = "./data/orders.csv"
    #   CSV.read(filename).each do |row|
    #     id = row[0].to_i
    #     products ={}
    #     products_string = row[1].split(';')
    #     products_string.each do |product|
    #       product_split = product.split(':')
    #       products[product_split[0]] = product_split[1].to_f
    #     end
    #     customer = Customer.find(row[2].to_i)
    #     fulfillment_status = row[3].to_sym
    #     order = Order.new(id, products, customer, fulfillment_status)
    #     all_orders << order
    #   end
    #   return all_orders
    # end
    
  end
end