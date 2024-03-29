module ReceiptsHelper
  def hour_military_select(id, name, selected_hour = Time.now.hour, cssclass='')
    subhtml=""
    (0..23).each { |hour|
      if (hour == selected_hour) 
        selected = "selected"
      else
        selected = ""
      end
      subhtml << "<option value='" << leading_zero(hour) << "'" << selected << ">" <<  leading_zero(hour) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end

  def ampm_select(id, name, selected_hour = Time.now.hour, cssclass='')
    subhtml=""
    subhtml << "<option value='AM' selected>AM</option>"
    subhtml << "<option value='PM'>PM</option>"
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)

  end

  def hour_select(id, name, selected_hour = Time.now.hour, cssclass='')
    subhtml=""
    (0..12).each { |hour|
      if (hour == selected_hour) 
        selected = "selected"
      else
        selected = ""
      end
      subhtml << "<option value='" << leading_zero(hour) << "'" << selected << ">" <<  leading_zero(to_american_format(hour)) << "</option>"
    }
#    javascript = "onchange='adjustAMPM()'"

   # if id.eql? "receipt_expiration_time_3i"
    #  javascript = "onchange='adjustAMPM()'"
   # end
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end

  def to_american_format hour
    if hour < 13
      hour = hour
    else
      hour = hour - 12
    end
    hour
  end
    
  def minute_select(id, name, selected_minute = Time.now.min, cssclass='')
    subhtml=""
    (0..59).each { |minute|
      if (minute == selected_minute) 
        selected = "selected"
      else
        selected = ""
      end
      subhtml << "<option value='" << leading_zero(minute) << "'" << selected << ">" <<  leading_zero(minute) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end

  def day_select(id, name, selected_day = Time.now.day, cssclass='')
    subhtml=""
    (1..31).each { |day|
      if (day == selected_day) 
        selected = "selected"
      else
        selected = ""
      end
      subhtml << "<option value='" << leading_zero(day) << "'" << selected << ">" <<  leading_zero(day) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end

  def year_hidden(id, name)
    html = "<input id='#{id}' name='#{name}' type='hidden' value='2012' />"
    render(:inline=> html)
  end

  def month_select(id, name, selected_month = Time.now.mon, cssclass='')
    subhtml=""
    beginMon = Time.now.mon - 2
    beginMon = 12-beginMon if beginMon < 0
    (beginMon..Time.now.mon).each { |month|
      if (month == selected_month) 
        selected = "selected"
      else
        selected = ""
      end
      subhtml << "<option value='" << leading_zero(month) << "'" << selected << ">" <<  leading_zero(month) << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end


  def month_abbrev(mon) 
    codes = {1 => "JAN", 2 => "FEB", 3 => "MAR", 4 => "APR", 5 => "MAY", 6 => "JUN", 7 => "JUL", 8 => "AUG", 9 => "SEP", 10 => "OCT", 11 => "NOV", 12 => "DEC" }
    codes[mon]
  end

  def month_abbrev_select(id, name, selected_month = Time.now.mon, cssclass='')
    subhtml=""
    codes = {1 => "JAN", 2 => "FEB", 3 => "MAR", 4 => "APR", 5 => "MAY", 6 => "JUN", 7 => "JUL", 8 => "AUG", 9 => "SEP", 10 => "OCT", 11 => "NOV", 12 => "DEC" }

    beginMon = Time.now.mon - 2
    beginMon = 12-beginMon if beginMon < 0
    (beginMon..Time.now.mon).each { |month|
      if (month == selected_month) 
        selected = "selected"
      else
        selected = ""
      end
      subhtml << "<option value='" << leading_zero(month) << "'" << selected << ">" <<  codes[month] << "</option>"
    }
    html = "<select class='#{cssclass}' id='#{id}' name='#{name}'>#{subhtml}</select>"
    render(:inline=> html)
  end
        
  def leading_zero(hour)
    "%02d" % hour
  end

end
