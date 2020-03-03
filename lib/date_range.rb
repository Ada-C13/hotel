require 'date'

require_relative 'hotel_system'
require_relative 'reservation'

module Hotel
	
	class DateRange

		attr_reader :start_date, :end_date

		def initialize(start_date, end_date)
			if Date.parse(start_date) == false 
				raise ArgumentError.new("Start date was not a real date.")
			else
				@start_date = Date.parse(start_date)
			end

			if Date.parse(end_date) == false
				raise ArgumentError.new("End date was not a real date.")
			else
				@end_date = Date.parse(end_date)
			end
		end

		def length_of_stay
			return (@end_date - @start_date)
		end
	
	end

end