class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  validates :title, presence: true
  validates :caption, presence: true
  validates :image, presence: true

  belongs_to :end_user
  has_many   :likes, dependent: :destroy
  has_many   :comments, dependent: :destroy
  has_many   :maps, dependent: :destroy
  has_many   :post_tags, dependent: :destroy
  has_many   :tags, through: :post_tags

  #画像が設定されない場合、no_image.jpgを表示させるメソッド
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def get_video(width, height)
    unless video.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      video.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    video.variant(resize_to_limit: [width, height]).processed
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
