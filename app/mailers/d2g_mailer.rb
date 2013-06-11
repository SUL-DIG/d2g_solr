class D2gMailer < ActionMailer::Base
  default from: "hettelj@stanford.edu"

  def email
      @response, @documents = get_solr_response_for_field_values(SolrDocument.unique_key,params[:id])
      if request.post?
        if params[:to]
          url_gen_params = {:host => request.host_with_port, :protocol => request.protocol}
          
          if params[:to].match(/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
            email = RecordMailer.email_record(@documents, {:to => params[:to], :message => params[:message]}, url_gen_params)
          else
            flash[:error] = I18n.t('blacklight.email.errors.to.invalid', :to => params[:to])
          end
        else
          flash[:error] = I18n.t('blacklight.email.errors.to.blank')
        end

        unless flash[:error]
          email.deliver 
          flash[:success] = "Email sent"
          redirect_to catalog_path(params['id']) unless request.xhr?
        end
      end

      unless !request.xhr? && flash[:success]
        respond_to do |format|
          format.js { render :layout => false }
          format.html
        end
      end
    end
  
#   def contact_message(opts={})
#     params=opts[:params]
#     @request=opts[:request]
#     @message=params[:message]
#     @email=params[:email]
#     @name=params[:name]
#     @subject=params[:subject]
#     @from=params[:from]
#     to=D2g::Application.config.contact_us_recipients[@subject]
#     cc=D2g::Application.config.contact_us_cc_recipients[@subject]    
#     mail(:to=>to,:cc=>cc, :subject=>"Contact Message from the Opening Night! Opera and Oratorio Premieres - #{@subject}") 
#   end
# 
#   def error_notification(opts={})
#     @exception=opts[:exception]
#     @mode=Rails.env
#     mail(:to=>D2g::Application.config.exception_recipients, :subject=>"Opening Night! Exception Notification running in #{@mode} mode")
#   end
  
end
