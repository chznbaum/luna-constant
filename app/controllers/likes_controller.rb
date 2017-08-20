class LikesController < ApplicationController
  before_action :find_likeable

  def new
    @like = Like.new
  end

  def create
    @like = @likeable.likes.new(like_params)
    @parent = @likeable
    until @parent.is_a?(Photo)
      @parent = @parent.commentable
    end
    if @like.save
      if @likeable.is_a?(Comment)
        liked_user = @likeable.user
        message = @likeable.body
        liker = User.find_by(id: @like.user_id)
        like_parent = @parent
        UserMailer.like_notification(liked_user, message, liker, like_parent).deliver_now
      end
      redirect_to @parent, notice: "Your like was successful."
    else
      render :new, notice: "Your like was unsuccessful."
    end
  end

  private
  def like_params
    params.require(:like).permit(:user_id, :photo_id, :comment_id)
  end

  def find_likeable
    @likeable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @likeable = Photo.find_by_id(params[:photo_id]) if params[:photo_id]
  end
end