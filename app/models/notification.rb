class Notification < ApplicationRecord

  belongs_to :end_user
  belongs_to :notifiable, polymorphic: true

  def message
   notifiable.notification_message
  end

  def notifiable_path
    notifiable.notification_path
  end
end
