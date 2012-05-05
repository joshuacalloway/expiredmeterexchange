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
#    @transaction.buyer_email = "unverified@gmail.com"
    @transaction.save
    redirect_to Receipt.find(@transaction.receipt_id).paypal_url(@transaction.id, home_paidreceipts_url, payment_notifications_url)
  end
end
