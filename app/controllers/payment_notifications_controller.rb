class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  # POST /payment_notifications
  # POST /payment_notifications.json
  def create
    PaymentNotification.create!(:params => params, :transaction_id => params[:invoice], :status => params[:payment_status], :txn_id => params[:txn_id])
    render :nothing => true
  end
end
