class ApplicationController < ActionController::Base
    protect_from_forgery
    
    helper_method :current_user
    before_filter :require_login
    
    private
    
    def require_login
        unless current_user
            redirect_to login_path
        end
    end
    
    def current_user_session
        return @current_user_session if defined?(@current_user_session)
        @current_user_session = UserSession.find
    end
    
    def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_user_session && current_user_session.record
    end
    
end
