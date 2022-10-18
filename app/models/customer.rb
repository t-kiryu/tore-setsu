class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,  dependent: :destroy
  has_many :post_comments
  has_many :bookmarks, dependent: :destroy

 # 会員情報等の表示で使用
  def full_name
    last_name + " " + first_name
  end

# 会員情報等の表示で漢字と合わせて使用
  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

end
