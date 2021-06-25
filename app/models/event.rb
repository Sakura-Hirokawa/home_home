class Event < ApplicationRecord
  belongs_to :user

  validates :title, :start_at, :end_at, presence: true
end
