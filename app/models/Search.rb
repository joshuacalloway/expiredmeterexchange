require 'time'
require 'date'

class Search
  attr_reader :options

  def initialize(model, options)
    @model = model
    @options = options || {}
  end

  def rate
    options[:rate]
  end

  def ticket_time
    options[:ticket_time]
  end

  def has_ticket_time?
    ticket_time.present?
  end

  def has_rate?
    rate.present?
  end


  def conditions
    c = {}
    c[:rate] = (rate.to_f-0.01).to_s
    c[:purchased_time_start] = to_date(date_from_options(ticket_time) + ' 00:00:00')
    c[:purchased_time_end] = to_date(time_from_options(ticket_time))

    c[:expiration_time_start] = to_date(time_from_options(ticket_time))
    c
  end
  
  def to_date(val)
     return DateTime.parse(val)
  end

  def time_from_options(which)
    which[:year] + "-" +("%02d" % which[:month]) + "-" + which[:day] + " " + which[:hour] + ":" + which[:minute] + ":00"
  end

  def date_from_options(which)
    which[:year] + "-" +("%02d" % which[:month]) + "-" + which[:day]
  end
end
