class Comment < ApplicationRecord
  validates :movie, :text, :user, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }

  belongs_to :user
  belongs_to :movie
end
