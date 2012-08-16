class GeneralMailerController < ApplicationController

  def contact

  end

  def send_contact_us
    if params[:email].length > 8
      if params[:body].length > 10
        @message = { :email => params[:email],
                     :subject => params[:subject],
                     :body => params[:body] }
        GeneralMailer.contact_us(@message)
        redirect_to root_path, :notice => "Thanks for contacting us!"
      else
        flash[:error] = "Message too short."
        render 'contact'
      end
    else
      flash[:error] = "You must enter an email address."
      render 'contact'
    end
    #
    # flash[:notice] = "Thanks for contacting us!"
    #redirect_to root_path, :notice => "Thanks for contacting us!"
  end

end
