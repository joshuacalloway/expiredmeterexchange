class AdminController < ApplicationController

  def receipts
    @receipts = Kaminari.paginate_array(Receipt.all).page(params[:page]).per(3)

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

end
