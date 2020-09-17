class Api::V1::NotesController < ApplicationController

    def show 
      # byebug
        note = Note.find(params[:id])
        render json: note
    end

    def index
        # notes = Note.all
        note = User.find(params[:user_id]).note
        render json: note
    end

    # def create
    #     note = Note.create(note_params)
    #     # do i find by username instead? 
    #     render json: note
    # end

    def update
        note = Note.find(params[:id])
        note.update(note_params)
        render json: note
    end

    private 

    def note_params
        params.require(:note).permit(:user_id, :text)
    end


end
