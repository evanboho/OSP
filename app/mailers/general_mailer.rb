class GeneralMailer < ActionMailer::Base
  default :from => "unnaive@gmail.com"
  default :to => "unnaive@gmail.com"

  def contact_us(message)
    @message = message
    mail(:email => message[:email],
         :subject => "OSP contact: #{message[:subject]}")
  end

end
