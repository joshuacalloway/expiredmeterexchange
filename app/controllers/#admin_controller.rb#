class AdminController < ApplicationController

  def receipts
    @receipts = Kaminari.paginate_array(Receipt.all).page(params[:page]).per(100)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  def payment_notifications
    @payment_notifications = PaymentNotification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_notifications }
    end
  end

  def transactions
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  def tickets
    @tickets = Ticket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroyreceipt
    @receipt = Receipt.find(params[:id])
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to admin_receipts_url }
      format.json { head :no_content }
    end
  end


end
