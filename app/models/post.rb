class Post < ApplicationRecord
  has_one_attached :image
  has_one_attached :video

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tag

  #ゲストのアクセス制限
  def guest_check
    if current_end_user == EndUser.find(1)
      redirect_to root_path,notice: "このページを見るには会員登録が必要です。"
    end
  end

  #画像が設定されない場合、no_image.jpgを表示させるメソッド
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.search(keyword)
  where(["title like? OR caption like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
