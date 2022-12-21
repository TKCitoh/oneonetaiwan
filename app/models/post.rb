class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  has_many :like, dependent: :destroymap
  has_many :comment, dependent: :destroy
  has_many :map, dependent: :destroy
  has_many :post_tag, dependent: :destroy
  has_many :tag, through: :post_tag

  def self.search(keyword)
  where(["title like? OR caption like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
