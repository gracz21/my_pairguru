class CommentsController < ApplicationController
  before_action :authenticate_user!

  expose :comment, parent: :current_user

  def create
    if comment.save
      redirect_to movie_path(params[:movie_id]), notice: 'Comment created successfully'
    else
      redirect_to movie_path(params[:movie_id]), alert: 'New comment is empty or you have already commented this movie'
    end
  end

  def destroy
    if comment.nil?
      redirect_to movie_path(params[:movie_id]), alert: "You don't own this comment"
    else
      comment.destroy
      redirect_to movie_path(params[:movie_id]), notice: 'Comment deleted successfully'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:movie_id, :text)
  end
end
