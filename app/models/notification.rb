class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :end_user
  belongs_to :notifiable, polymorphic: true

  def message
    if notifiable_type === "Post"
      "フォローしている#{notifiable.end_user.name}さんが#{notifiable.title}を投稿しました"
    else
      "投稿した#{notifiable.post.title}が#{notifiable.end_user.name}さんにいいねされました"
    end
  end

  def notifiable_path
    if self.notifiable_type === "Post"
      post_path(notifiable.id)
    else
      profile_path(notifiable.end_user.id)
    end
  end
end
