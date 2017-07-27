class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.create(comment_params)
    if comment.persisted?
      redirect_to movie_path(params[:movie_id]), notice: 'Comment created successfully'
    else
      redirect_to movie_path(params[:movie_id]), alert: 'New comment is empty or you have already commented this movie'
    end
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    if comment.user_id == current_user.id
      comment.destroy
      redirect_to movie_path(params[:movie_id]), notice: 'Comment deleted successfully'
    else
      redirect_to movie_path(params[:movie_id]), alert: "You don't own this comment"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:movie_id, :text)
  end
end
