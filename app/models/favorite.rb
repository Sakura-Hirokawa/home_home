class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :list

  # 1人が１つの投稿に対して、１つしかいいねをつけられないようにする
  validates :list_id, uniqueness: { scope: :user_id }
end
