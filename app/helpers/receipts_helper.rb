module ReceiptsHelper
  def hour_select(id, name, cssclass='')
    subhtml=""
    (0..23).each { |hour|
      subhtml << "<option value='" << leading_zero(hour) << "'>" <<  leading_zero(hour) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end

  def minute_select(id, name, cssclass='')
    subhtml=""
    (0..59).each { |minute|
      subhtml << "<option value='" << leading_zero(minute) << "'>" <<  leading_zero(minute) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end

  def day_select(id, name, cssclass='')
    subhtml=""
    (1..31).each { |day|
      subhtml << "<option value='" << leading_zero(day) << "'>" <<  leading_zero(day) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end
    
  def leading_zero(hour)
    "%02d" % hour
  end

end
