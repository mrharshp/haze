class Group < ApplicationRecord
  has_many :group_memberships
  has_many :lists
  has_one :conversation
  has_many :users, through: :group_memberships
  validates :name, presence: true
  mount_uploader :photo, PhotoUploader
end
