class CommentDecorator < Draper::Decorator
  delegate_all

  def is_author
    h.current_user.nil? ? false : h.current_user.id == object.user.id
  end

end
