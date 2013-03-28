class D2gMailer < ActionMailer::Base
  default from: "no-reply@d2g.stanford.edu"

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
    mail(:to=>to,:cc=>cc, :subject=>"Contact Message from the Don to Giovanni Opera and Oratorio Citation Collection - #{@subject}") 
  end

  def error_notification(opts={})
    @exception=opts[:exception]
    @mode=Rails.env
    mail(:to=>D2g::Application.config.exception_recipients, :subject=>"Don to Giovanni Exception Notification running in #{@mode} mode")
  end
  
end
