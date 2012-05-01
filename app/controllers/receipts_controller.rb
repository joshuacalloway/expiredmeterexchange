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
    @receipts = Array.new(2) { Receipt.new } # set up any defaults here
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.json
  def new
    @receipt = Receipt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/1/edit
  def edit
    @receipt = Receipt.find(params[:id])
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(params[:receipt])
    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
        format.json { render json: @receipt, status: :created, location: @receipt }
      else
        format.html { render action: "new" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.json
  def update
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      if @receipt.update_attributes(params[:receipt])
        format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt = Receipt.find(params[:id])
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to receipts_url }
      format.json { head :no_content }
    end
  end
end
