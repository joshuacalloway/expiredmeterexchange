class UserMailer < ActionMailer::Base
#  default from: "from@example.com"
  default :from => "notifications@example.com"
 
  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => "joshua.calloway@gmail.com", :subject => "Welcome to My Awesome Site")
  end
end
