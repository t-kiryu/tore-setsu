class Tag < ApplicationRecord
  has_many :tag_lists, dependent: :destroy
  #To Study(中間テーブルの役割、throughメソッドの役割を理解しよう)
  has_many :posts, through: :tag_lists

  validates :name, presence: true, uniqueness: true

end
