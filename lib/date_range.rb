require 'date'

require_relative 'reservation'

module Hotel
	
	class DateRange

		attr_reader :start_date, :end_date

		def initialize(start_date, end_date)
			if !Date.parse(start_date) or !Date.parse(end_date)
				raise ArgumentError.new("Invalid date provided for start or end.")
			elsif Date.parse(end_date) < Date.parse(start_date)
				raise ArgumentError.new("End date cannot be earlier than start.")
			else
				@start_date = Date.parse(start_date)
				@end_date = Date.parse(end_date)
			end
		end

		# Provides the number of days of length of stay.
		def length_of_stay
			return (@end_date - @start_date)
		end
	
	end

end