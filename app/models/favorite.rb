class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  after_create do
    create_notification(end_user_id: post.end_user_id)
  end

  validates :end_user_id, uniqueness: {scope: :post_id}
end
