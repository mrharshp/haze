class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
end
