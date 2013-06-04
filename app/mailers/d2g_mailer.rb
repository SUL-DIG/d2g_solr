class D2gMailer < ActionMailer::Base
  default from: "hettelj@stanford.edu"

  def contact_message(opts={})
    params=opts[:params]
    @request=opts[:request]
    @message=params[:message]
    @email=params[:email]
    @name=params[:name]
    @subject=params[:subject]
    @from=params[:from]
    to=D2g::Application.config.contact_us_recipients[@subject]
    cc=D2g::Application.config.contact_us_cc_recipients[@subject]    
    mail(:to=>to,:cc=>cc, :subject=>"Contact Message from the Opening Night! Opera and Oratorio Premieres - #{@subject}") 
  end

  def error_notification(opts={})
    @exception=opts[:exception]
    @mode=Rails.env
    mail(:to=>D2g::Application.config.exception_recipients, :subject=>"D2g Exception Notification running in #{@mode} mode")
  end
  
end
