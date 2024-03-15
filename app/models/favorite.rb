class Favorite < ApplicationRecord
  include Notifiable
  belongs_to :end_user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(end_user_id: post.end_user_id)
  end

  def notification_message
    "投稿した#{post.title}が#{end_user.name}さんにいいねされました"
  end

  def notification_path
    profile_path(end_user)
  end

  validates :end_user_id, uniqueness: {scope: :post_id}
end
