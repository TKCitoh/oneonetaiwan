class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  has_many :likes, dependent: :destroymap
  has_many :comments, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tag

  def self.search(keyword)
  where(["title like? OR caption like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
