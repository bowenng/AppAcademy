class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            log_in(user)
        else 
            flash.now[:errors] = user.errors.full_messages
            render :new
        end
    end

    def new
        render :new
    end
    
    private 
    def user_params
        params.require(:user).permit(:username, :password)
    end

end