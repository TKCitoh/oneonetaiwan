class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  validates :name,  presence: true, length: { in: 2..10 }, uniqueness: true
  validates :email, presence: true

  has_one_attached :profile_image

  def self.guest
    find_or_create_by!(email: "ttt@ttt.com") do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.password_confirmation = end_user.password
      end_user.name = "ゲスト"
    end
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/javascript/images/no_image.jpeg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
