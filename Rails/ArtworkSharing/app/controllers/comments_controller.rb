class CommentsController < ApplicationController
    def index
        case 
        when params[:artwork_id]
            comments = Artwork.find(params[:artwork_id]).comments
        when params[:commenter_id]
            comments = User.find(params[:commenter_id]).comments
        else
            comments = Comment.all
        end
        render json: comments
    end

    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else 
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end
    
    private
    def comment_params
        params.require(:comment).permit(:body, :commenter_id, :artwork_id)
    end
end