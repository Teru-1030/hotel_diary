class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    
    validates :title, presence: true
    validates :body, presence: true
    
    
    
   def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_img.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
   end
   
   def self.search_for(content, method)
     if method == 'perfect'
       Post.where(title: content)
     else
       Post.where('title LIKE ?', '%' + content + '%')
     end
   end
   
   def guest_user?
    email == GUEST_USER_EMAIL
   end
   
   def liked_by?(user)
     likes.exists?(user_id: user.id)
   end

end
