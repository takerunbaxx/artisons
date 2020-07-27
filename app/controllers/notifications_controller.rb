class NotificationsController < ApplicationController
  
  before_action :require_user_logged_in
    
def index
  @notifications = current_user.passive_notifications.order(created_at: :asc).page(params[:page]).per(25)
  @notifications.where(checked: false).each do |notification|
  notification.update_attributes(checked: true)  end
end

def destroy
    @notifications = current_user.passive_notifications
    @notifications.destroy_all
    redirect_to notifications_url
end

end
