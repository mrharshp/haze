class Split < ApplicationRecord
  belongs_to :expense
  belongs_to :user
  validates :customsplit, presence: true
  validates :paid, inclusion: { in: [true, false] }
end
