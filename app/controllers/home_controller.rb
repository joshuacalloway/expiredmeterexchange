class HomeController < ApplicationController
  
  def index
  end

  def paidreceipts
# select r.* from receipts r, transactions t where t.receipt_id = r.id and t.buyer_email = 'dgorodess@gmail.com' and t.status='paid at paypal'
    buyer_email = params[:buyer_email]
    @receipts = Kaminari.paginate_array(Receipt.joins("JOIN transactions on transactions.receipt_id = receipts.id and transactions.status = 'paid at paypal' and transactions.buyer_email='#{buyer_email}'")).page(params[:page]).per(1)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  def search
    @transaction = Transaction.new

    @search = Search.new(Receipt, params)
    @receipts = Kaminari.paginate_array(Receipt.search(@search)).page(params[:page]).per(1)

    if @receipts.length > 0
      @transaction.receipt_id = @receipts[0].id
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
