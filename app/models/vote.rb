class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :list_item
end
