class List < ApplicationRecord
  belongs_to :user
  has_many :list_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :date, presence: true
  validates :first_item, presence: true, length: {maximum: 200}
end
