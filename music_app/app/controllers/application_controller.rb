class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    
    def current_user                
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token]) # <=  #user table ST, session ST
    end

    def logged_in?
        !!current_user
    end

    def ensure_login
        redirect_to new_session_url unless logged_in?
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_user
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def require_no_user!
        redirect_to user_url(current_user) if logged_in?
    end 

    def require_user!
        redirect_to new_session_url unless logged_in?
    end
    
end
