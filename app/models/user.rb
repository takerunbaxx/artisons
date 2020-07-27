class User < ApplicationRecord
  
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :relationships
  has_many :comments, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :opposite_side_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :opposite_side_relationship, source: :user
  has_many :likes, dependent: :destroy
  has_many :likings, through: :likes, source: :post
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  mount_uploader :image, ImageUploader

def follow(other_user)
  unless self==other_user
  self.relationships.find_or_create_by(follow_id: other_user.id)
  end
end

def unfollow(other_user)
  relationship=self.relationships.find_by(follow_id: other_user.id)
  relationship.destroy if relationship
end

def following?(other_user)
  self.followings.include?(other_user)
end

def like(post)
  self.likes.find_or_create_by(post_id: post.id)
end

def unlike(post)
  have_been_liked=self.likes.find_by(post_id: post.id)
  have_been_liked.destroy if have_been_liked
end

def liking?(post)
  self.likings.include?(post)
end

def remove_image
  self.remove_image!
  self.save
end

def posts_together
    Post.where(user_id: self.following_ids + [self.id])
end

def create_notification_follow!(current_user)
     temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow')
      notification.save if notification.valid?
    end
end
  
  
  
end