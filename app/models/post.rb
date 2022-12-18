class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  def self.search(keyword)
  where(["title like? OR caption like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
