require 'date'
require 'securerandom'

require_relative 'calendar'
require_relative 'hotel'

class Reservation
  attr_accessor :start_date, :end_date

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  
  def reservation(start_date, end_date)
    {
      :id => (SecureRandom.alphanumeric).slice(0...7).upcase,
      :start_date => Date.parse(start_date).iso8601, 
      :end_date => Date.parse(end_date).iso8601, 
      :total_nights => (Date.parse(end_date) - Date.parse(start_date)).to_i,
      :cost => ((Date.parse(end_date) - Date.parse(start_date)).to_i * 200)
    }
  end

end