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
    @transaction.save
    r = Receipt.find(@transaction.receipt_id)
    response = EXPRESS_GATEWAY.setup_purchase(100, express_options(@transaction, r))

    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    
  end

  private
  def express_options transaction, receipt
    options = {}
    options[:ip] = request.remote_ip
    options[:return_url] = home_paidreceipts_url
    options[:cancel_return_url] = home_welcome_url
    options[:transaction_id] = transaction.id
    options[:order_id] = transaction.id

    options[:items] = [{
      :name => "Contact Info for Meter receipt",
      :number => receipt.id,
      :quantity => 1,
      :amount => 100,
      :url => nil,
      :order_id => transaction.id,
      :description => "Contact Information for 1 meter receipt"
    }]

    options[:shipping] = 0
    options[:handling] = 0
    options[:tax] = 0
    options
  end
end
