class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.created_at_desc.includes(:item)
  end
end
