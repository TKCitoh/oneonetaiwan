class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :post, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :like, dependent: :destroy

  def self.guest
  find_or_create_by!(email: 'ttt@ttt.com') do |end_user|
    end_user.password = SecureRandom.urlsafe_base64
    end_user.password_confirmation = end_user.password
    end_user.name = 'ゲスト'
  end
  end
end
