class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user

  private

  def set_notifications
    notifications = Noticed::Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = current_user.notifications.unread
    @read = current_user.notifications.read
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      super
    end
  end
end