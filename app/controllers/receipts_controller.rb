class ReceiptsController < ApplicationController
  # GET /receipts
  # GET /receipts.json
  def index
    @receipts = Receipt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receipt }
    end
  end

  def any_invalid?(receipts)
    receipts.each { |r| return true if !r.valid? }
    return false
  end

  def createmultiple
    @receipts = []
    notices = ''
    count = 0
    params["receipt"].each_value do |r| 
      receipt = Receipt.new(r)
      receipt.email = params[:email]
      count = count+1 if receipt.save
    end

    notices << count.to_s << ' receipts saved success.'
    respond_to do |format|
      flash[:notice] = notices
      format.html { redirect_to receipts_enter_path } # createmultiple.html.erb
      format.json { render json: @receipts }
    end
  end
  
  # GET /receipts/enter
  # GET /receipts/enter.json
  def enter
    @receipts = Array.new(3) { Receipt.new } # set up any defaults here
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.json
  def new
    session[:receipt_params] ||= {}
    @receipt = Receipt.new(session[:receipt_params])
    @receipt.current_step = session[:receipt_step]
  end

  # GET /receipts/1/edit
  def edit
    @receipt = Receipt.find(params[:id])
  end

  # POST /receipts
  # POST /receipts.json
  def create
    session[:receipt_params].deep_merge!(params[:receipt]) if params[:receipt]
    @receipt = Receipt.new(session[:receipt_params])
    @receipt.current_step = session[:receipt_step]
    if @receipt.valid?
      if @receipt.last_step?
        @receipt.save
      else
        @receipt.next_step
      end
      session[:receipt_step] = @receipt.current_step
    end
    if ! @receipt.new_record?
     # session[:receipt_params] = nil
      flash[:notice] = "Receipt saved."
      redirect_to home_welcome_path
    else
      redirect_to new_receipt_url
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.json
  def update
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      if @receipt.update_attributes(params[:receipt])
        format.html { redirect_to receipt_path(@receipt), notice: 'Receipt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

end
