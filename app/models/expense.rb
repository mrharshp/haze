class Expense < ApplicationRecord
  belongs_to :group
  has_many :splits
  validates :description, presence: true
  validates :value, presence: true
  validates :currency, presence: true
end
