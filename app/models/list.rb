class List < ApplicationRecord
  belongs_to :group
  has_many :list_items
end
