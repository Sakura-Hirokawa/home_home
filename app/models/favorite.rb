class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :list

  #1人が１つの投稿に対して、１つしかいいねをつけられないようにする
  validates_uniqueness_of :list_id, scope: :user_id
end
