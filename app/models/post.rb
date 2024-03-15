class Post < ApplicationRecord
  include Notifiable
  belongs_to :end_user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :view_counts, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_one_attached :image

  after_create do
    end_user.followers.each do |follower|
      notifications.create(end_user_id: follower.id)
    end
  end

  def notification_message
    "フォローしている#{end_user.name}さんが#{title}を投稿しました"
  end

  def notification_path
    post_path(self)
  end

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

  def save_tags(tags)
    #タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    #現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    #送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    #古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    #新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << tag
    end
  end

end
