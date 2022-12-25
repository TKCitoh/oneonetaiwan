class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  validates :title, presence: true
  validates :caption, presence: true
  validates :image, presence: true
  validates :video, presence: true

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tag

  #画像が設定されない場合、no_image.jpgを表示させるメソッド
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def get_video
    unless video.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      video.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    video
  end

  def self.search(keyword)
  where(["title like? OR caption like?", "%#{keyword}%", "%#{keyword}%"])
  end
  
  def liked_by?(end_user)
    likes.exists?(end_user_id: end_user.id)
  end
end
