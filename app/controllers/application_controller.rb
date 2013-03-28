class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller 
   include Blacklight::Controller
  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  protect_from_forgery
  
  layout "d2g"
  
  helper_method :show_terms_dialog?, :on_home_page, :on_show_page, :on_search_page, :request_path
  
  def seen_terms_dialog?
    cookies[:seen_terms] || false
  end
  
  def show_terms_dialog?
    %w{staging}.include?(Rails.env) && !seen_terms_dialog?   # we are using the terms dialog to show a warning to users who are viewing the site on staging
  end
  
  def accept_terms
    cookies[:seen_terms] = { :value => true, :expires => 1.day.from_now } # they've seen it now!
    if params[:return_to].blank?
      render :nothing=>true
    else
      redirect_to params[:return_to]
    end
  end
  
  def request_path
    Rails.application.routes.recognize_path(request.path)
  end
  
  def on_home_page
    request_path[:controller] == 'catalog' && request_path[:action] == 'index' && params[:f].blank? && params[:q].blank?
  end
  
  def on_show_page
    request_path[:controller] == 'catalog' && request_path[:action] == 'show'
  end

  def on_search_page
    request_path[:controller] == 'catalog' && request_path[:action] == 'index' && !on_home_page
  end

      
	def exception_on_website(exception)
		@exception=exception
		D2gMailer.error_notification(:exception=>@exception).deliver unless D2g::Application.config.exception_recipients.blank? 
			if D2g::Application.config.exception_error_page
				logger.error(@exception.message)
				logger.error(@exception.backtrace.join("\n"))
			render "500", :status => 500
			else
				raise(@exception)
		end
	end   
end
