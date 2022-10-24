class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  validates :comment, presence: true, length: { minimum: 1, maximum: 100}

end
