class ListItem < ApplicationRecord
  belongs_to :list
  validates :title, presence: true
  validates :upvote, presence: true
  validates :downvote, presence: true
end
