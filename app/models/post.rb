class Post < ApplicationRecord
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample.png')
      image.attach(io: File.open(file_path), filename: 'sample.png', content_type: 'image/png')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  #ransackが検索可能な属性名を指定
  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

end
