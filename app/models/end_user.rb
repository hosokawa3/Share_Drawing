class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'user.jpeg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #退会したユーザーが同じアカウントでログインできないように
  def active_for_authentication?
    super && (is_active == true)
  end

  GUEST_END_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_END_USER_EMAIL) do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name = "guestuser"
    end
  end

  def guest_end_user?
    email == GUEST_END_USER_EMAIL
  end

end