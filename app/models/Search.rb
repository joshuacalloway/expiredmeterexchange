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
    c[:purchased_time_start] = time_from_options(ticket_time.merge({ :hour=>0, :minute=>0,:second=>0}))
    c[:purchased_time_end] = time_from_options(ticket_time)
    c[:expiration_time_start] = time_from_options(ticket_time)
    c
  end
  
  def to_date(val)
     return Time.parse(val).in_time_zone("UTC")
  end

  def time_from_options(which)
    Time.new(which[:year], which[:month], which[:day], which[:hour], which[:minute], 0, "-05:00")
  end

  def date_from_options(which)
    Date.new(which[:year], which[:month], which[:day])
  end
end
