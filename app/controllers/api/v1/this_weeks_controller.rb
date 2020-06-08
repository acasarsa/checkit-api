class Api::V1::ThisWeeksController < ApplicationController

    def index
        this_week = ThisWeek.all
        render json: this_week
    end

    def create
        this_week = ThisWeek.find_or_create_by!(this_week_params)
        # do i find by username instead? 
        render json: this_week
    end

    def update
        this_week = ThisWeek.find(params[:id])
        this_week.update(this_week_params)
        render json: this_week
    end

    private 

    def this_week_params
        params.require(:this_week).permit(:user_id, :text)
    end
end

# on cdm fetch the note