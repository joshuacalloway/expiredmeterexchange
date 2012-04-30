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
      redirect_to new_ticket_path, :rate => 7
#      redirect_to :controller => 'ticket', :action => 'new', :rate => params[:rate]
    end
  end
end
