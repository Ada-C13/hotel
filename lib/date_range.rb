module Hotel

	class DateRange

		attr_reader :start_date, :end_date

		def initialize(start_date, end_date)
			@start_date = start_date
			@end_date = end_date
		end

		# Checks if a range falls within another range.
		def include_range?(token, incoming_range)
			if token == :booking 
				return (incoming_range.start_date >= self.start_date) && (incoming_range.end_date < self.end_date)
			elsif token == :searching 
				return (incoming_range.start_date >= self.start_date) && (incoming_range.end_date <= self.end_date)
			end
		end

		# Checks if a range includes a single date.
		def include_single_date?(incoming)
			range = @start_date...@end_date

			range.include?(incoming) ? true : false
		end

	end

end