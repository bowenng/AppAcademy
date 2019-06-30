class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def index
        all_users = User.all
        render json: all_users
    end

    def show
        id = params[:id]
        render json: User.find(id)
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: user
    end

    def update
        id = params[:id]
        user = User.find(id)
        if user.update_attributes(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end
    private
    def user_params
        params.require(:user).permit(:username)
    end
end