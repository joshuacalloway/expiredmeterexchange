class TransactionsController < ApplicationController


  # GET /transactions/new
  # GET /transactions/new.json
  def new
    @transaction = Transaction.new
    @transaction.receipt_id = params[:receipt_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end


  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(params[:transaction])
    return_url = home_paidreceipts_url + "?buyer_email="+@transaction.buyer_email
    redirect_to Receipt.find(@transaction.receipt_id).paypal_url(@transaction.id, return_url, payment_notifications_url)
  end
end
