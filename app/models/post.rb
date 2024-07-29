class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    
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
       Post.where(name: content)
     else
       Post.where('name LIKE ?', '%' + content + '%')
     end
   end

end
