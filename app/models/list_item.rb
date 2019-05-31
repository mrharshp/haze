class ListItem < ApplicationRecord
  belongs_to :list
  belongs_to :user
  validates :title, presence: true
  has_many :votes
  mount_uploader :photo, PhotoUploader
end
