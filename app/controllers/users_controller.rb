class UsersController < ApplicationController
  def most_active
    @most_active_users = User.most_active
  end
end
