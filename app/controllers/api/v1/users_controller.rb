class Api::V1::UsersController < ApplicationController

    def show 
        user = User.find(params[:id])
        render json: user, include: [:lists, :tasks, :note], status: :ok
    end

    def login 
        user = User.find_by(username: params[:username])
        render json: user, include: [:lists, :tasks, :note], status: :ok
    end

    def index 
        users = User.all
        render json: users, include: [:lists, :tasks, :note], status: :ok
    end

    def create 
      # byebug
        user = User.find_or_create_by(user_params)
        user.note
        render json: user, include: [:lists, :tasks, :note], status: :ok
    end

    private 

    def user_params
        params.require(:user).permit(:username)
    end

end
