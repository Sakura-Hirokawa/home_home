class ListComment < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :comment, presence: true, length: {minimum: 2}
end
