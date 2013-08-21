class D2gMailer < ActionMailer::Base
  default from: "opening_night@lists.stanford.edu"

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
    mail(:to=>to,:cc=>cc, :subject=>"Contact Message from the French Revolution Digital Archive - #{@subject}") 
  end
end
