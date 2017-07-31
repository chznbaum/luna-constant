class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)

    respond_to do |format|    
      if @comment.save
        format.html { redirect_to photos_url, notice: 'Your comment was successfully posted.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Photo.find_by_id(params[:photo_id]) if params[:photo_id]
  end
end