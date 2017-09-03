class UsersController < ApplicationController
  expose :most_active_users, -> { User.most_active }

  def most_active; end
end
