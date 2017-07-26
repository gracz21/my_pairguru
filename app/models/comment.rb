class Comment < ApplicationRecord
  validates :movie, :text, :user, presence: true

  belongs_to :user
  belongs_to :movie
end
