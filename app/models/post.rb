class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence:  true, length: { maximum: 100}
  validates :category, presence:  true
  validates :content, presence:  true, length: { maximum: 10000}
  validates :outline, presence: true, length: { maximum: 400 }
  

  mount_uploader :post_image_name, ImageUploader
  
def remove_post_image_name
  self.remove_post_image_name!
  self.save
end


  def create_notification_like!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
    save_notification_comment!(current_user, comment_id, temp_id['user_id']) end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
end

def save_notification_comment!(current_user, comment_id, visited_id)
        notification = current_user.active_notifications.new(
          post_id: id,
          comment_id: comment_id,
          visited_id: visited_id,
          action: 'comment')
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
end

end
