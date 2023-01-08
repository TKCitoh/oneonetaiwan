class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  validates :title, presence: true
  validates :caption, presence: true, length: { maximum: 50 }
  validates :image, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  belongs_to :end_user
  has_many   :likes, dependent: :destroy
  has_many   :comments, dependent: :destroy
  has_many   :maps, dependent: :destroy
  has_many   :post_tags, dependent: :destroy
  has_many   :tags, through: :post_tags

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search(search)
    if search != ""
      Post.where(["title like? OR caption like?", "%#{search}%", "%#{search}%"])
    else
      Post.includes(:end_user)
    end
  end

  def liked_by?(end_user)
    likes.exists?(end_user_id: end_user.id)
  end

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
  end
end
