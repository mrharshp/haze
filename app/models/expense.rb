class Expense < ApplicationRecord
  belongs_to :group
  has_many :splits
end
