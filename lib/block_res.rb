module Stayappy
  class BlockRes < Reservation
    attr_reader :block, :discounted_rate
  
    def initialize(block, check_in, check_out, discounted_rate)
     if block.count > 5 
        raise ArgumentError.new("There can only be five rooms in a block.") 
      end
      @block = block
      @discounted_rate = discounted_rate
      super(block, check_in, check_out)
    end 
  end
end