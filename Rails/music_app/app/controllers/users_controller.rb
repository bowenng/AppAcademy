class UsersController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.new(username: user_params[:username], email: user_params[:email], password: user_params[:password])

        if user.save
            login(user)
            render :plain, "Success"
        else
            flash.now[:errors] = user.errors.full_messages
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end