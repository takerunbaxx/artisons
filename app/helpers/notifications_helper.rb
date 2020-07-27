module NotificationsHelper
  
  
def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @visiter_comment = notification.comment_id
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"  followed  you"
      when "like" then
        tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"  liked  "+tag.a('yourpost', href:post_path(notification.post_id), style:"font-weight: bold;")+"  your poat"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)&.content
        tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+" commented on "+tag.a('your post', href:post_path(notification.post_id), style:"font-weight: bold;")
    end
end

def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
end


end
