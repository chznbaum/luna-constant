class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @parent = @commentable
    until @parent.is_a?(Photo)
      @parent = @parent.commentable
    end

    respond_to do |format|    
      if @comment.save
        if @commentable.is_a?(Comment)
          replying_to = @commentable.user
          prior_message = @commentable.body
          message = @comment.body
          commenter = User.find_by(params[:user_id])
          comment_parent = @parent
          UserMailer.comment_reply_notification(replying_to, prior_message, message, commenter, comment_parent).deliver_now
        end
        format.html { redirect_to @parent, notice: 'Your comment was successfully posted.' }
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