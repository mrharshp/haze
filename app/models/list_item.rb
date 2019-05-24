class ListItem < ApplicationRecord
  belongs_to :list
  validates :title, presence: true
  validates :description, presence: true
end
