class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(session_params[:username], session_params[:password])
        if user.nil?
            render :new
        else
            log_in(user)
        end
    end

    def destroy
        log_out
        redirect_to cats_url
    end

    private
    def session_params
        params.require(:session).permit(:username, :password)
    end
end