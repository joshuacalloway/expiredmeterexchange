module Admin
class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def matched
# select t.* from tickets t, receipts r where t.ticket_time between r.purchased_time and r.expiration_time and t.rate <= r.rate;

    receipt = Receipt.new
    receipt.rate = 1.75
    receipt.purchased_time = Time.parse('May 05, 2012 16:00')
    receipt.expiration_time = Time.parse('May 05, 2012 17:00')

    @tickets = Ticket.select("distinct tickets.*").joins('JOIN receipts on tickets.ticket_time between receipts.purchased_time and receipts.expiration_time and tickets.rate <= receipts.rate')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/enter
  def enter
    @ticket = Ticket.new
    if params[:rate]
      @ticket.rate = params[:rate]
      @ticket.cell_number = params[:cell_number]
      @ticket.ticket_time = params[:ticket_time][:year] + "-" + params[:ticket_time][:month]+"-" + params[:ticket_time][:day] + " " + params[:ticket_time][:hour]+":"+params[:ticket_time][:minute]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to admin_ticket_path(@ticket), notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to admin_tickets_url }
      format.json { head :no_content }
    end
  end
end
end
