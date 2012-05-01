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
      redirect_to tickets_enter_path(:rate => params[:rate], :ticket_datetime => { :year => params[:ticket_datetime][:year], :month => params[:ticket_datetime][:month], :day => params[:ticket_datetime][:day], :hour => params[:ticket_datetime][:hour], :minute => params[:ticket_datetime][:minute]})
    end
  end

  def time_from_options(which)
    which[:year] + "-" +("%02d" % which[:month]) + "-" + which[:day] + " " + which[:hour] + ":" + which[:minute] + "00"
  end

end
