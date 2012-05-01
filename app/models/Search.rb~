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

  def ticket_datetime
    options[:ticket_datetime]
  end

  def has_ticket_datetime?
    ticket_datetime.present?
  end

  def has_rate?
    rate.present?
  end


  def conditions
    c = {}
    c[:rate] = ((rate.to_f-0.01).to_s ..'100')
    c[:purchased_time] = (date_from_options(ticket_datetime).to_s + ' 00:00:00'..time_from_options(ticket_datetime))
    c[:expiration_time] = (time_from_options(ticket_datetime)..date_from_options(ticket_datetime) + ' 23:59:59')

    c
  end

  def time_from_options(which)
    which[:year] + "-" +("%02d" % which[:month]) + "-" + which[:day] + " " + which[:hour] + ":" + which[:minute] + "00"
  end

  def date_from_options(which)
    which[:year] + "-" +("%02d" % which[:month]) + "-" + which[:day]
  end
end
