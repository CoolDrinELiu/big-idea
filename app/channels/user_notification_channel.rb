class UserNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "UserNotificationChannel.#{params[:user_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
