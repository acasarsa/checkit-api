class Api::V1::UsersController < ApplicationController

    def show 
        user = User.find(params[:id])
    end

    def login 
        user = User.find_by(username: params[:username])
        render json: user, status: 201
    end

    def index 
        users = User.all
        render json: users, status: 201
    end

    def create 
        user = User.create!(user_params)
    end

    private 

    def user_params
        params.require(:user).permit(:username, :password, :name)
    end

end
