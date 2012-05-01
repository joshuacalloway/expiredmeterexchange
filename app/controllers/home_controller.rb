class HomeController < ApplicationController
  
  def index
  end

  def search
    @search = Search.new(Receipt, params)
    @receipts = Receipt.search(@search)

    if @receipts.length > 0
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @receipts }
      end
    else
      redirect_to tickets_enter_path(:rate => params[:rate], :ticket_time => { :year => params[:ticket_time][:year], :month => params[:ticket_time][:month], :day => params[:ticket_time][:day], :hour => params[:ticket_time][:hour], :minute => params[:ticket_time][:minute]})
    end
  end

  def time_from_options(which)
    which[:year] + "-" +("%02d" % which[:month]) + "-" + which[:day] + " " + which[:hour] + ":" + which[:minute] + "00"
  end

end
