class Post < ApplicationRecord
    has_many_attached :images
    belongs_to :user
    
  def get_images
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_img.png')
      images.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    images
  end
    
  
end
