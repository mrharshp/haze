class List < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :list_items
  validates :name, presence: true
  mount_uploader :photo, PhotoUploader
end
