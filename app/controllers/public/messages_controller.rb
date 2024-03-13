class Public::MessagesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    message = Message.new(message_params)
    message.end_user_id = current_end_user.id
    if message.save
      redirect_to room_path(message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :message)
  end
end
