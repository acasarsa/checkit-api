class Api::V1::NotesController < ApplicationController

    # def show 
    #     note = Note.find(params[:id])
    #     render json: note
    # end

    def index
        notes = Note.all
        render json: notes
    end

    def create
        note = Note.find_or_create_by!(note_params)
        # do i find by username instead? 
        render json: note
    end

    def update
        note = Note.find(params[:id])
        note.update(note_params)
        render json: note
    end

    private 

    def note_params
        params.require(:note).permit(:user, :text)
    end


end
