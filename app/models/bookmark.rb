class Bookmark < ApplicationRecord
  belongs_to :post
  belongs_to :customer

  # 重複登録防止
  validates :customer_id, uniqueness: { scope: :post_id }

end
