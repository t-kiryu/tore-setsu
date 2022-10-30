class Post < ApplicationRecord
  has_one_attached :image

  has_many :post_comments, dependent: :destroy
  has_many :tag_lists, dependent: :destroy
  has_many :tags, through: :tag_lists
  has_many :bookmarks, dependent: :destroy

  belongs_to :customer

  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :introduction, presence: true, length: { minimum: 1, maximum: 255 }


  # 画像添付なし=>no_image.jpg, 添付あり=>image
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # ブックマーク済みか検証
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end

  # キーワード検索：部分一致あり=>該当物の表示、部分一致なし=>全て表示
  def self.search(search)
    if search
      where(['introduction LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
