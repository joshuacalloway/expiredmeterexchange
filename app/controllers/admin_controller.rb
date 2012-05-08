class AdminController < ApplicationController
  http_basic_authenticate_with :name => "frodo", :password => "thering"

  def send_welcome_email
    UserMailer.welcome_email(nil).deliver
    redirect_to admin_path
  end

  def send_matched_receipt_email
    @receipts = Receipt.select("distinct receipts.*").joins('JOIN tickets on tickets.ticket_time between receipts.purchased_time and receipts.expiration_time and tickets.rate <= receipts.rate')
    UserMailer.receiptavailable_email(@receipts.first)
    redirect_to admin_path
  end

end
