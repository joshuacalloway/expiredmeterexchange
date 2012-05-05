class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  # POST /payment_notifications
  # POST /payment_notifications.json
  def create
    PaymentNotification.create!(:params => params, :transaction_id => params[:invoice], :status => params[:payment_status], :txn_id => params[:txn_id])
    transaction = Transaction.find(params[:invoice])
    transaction.buyer_email = params[:payer_email]
    transaction.save
    render :nothing => true
  end
end
