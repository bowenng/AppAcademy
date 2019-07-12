class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def login(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout(user)
        user.reset_session_token!
        session[:session_token] = nil
    end
    def current_user
        return nil unless self.session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

end
