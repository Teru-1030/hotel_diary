class Post < ApplicationRecord
    has_many_attached :images
    belongs_to :user
    
  def get_images
  if images.attached?
    images
  else
    file_path = Rails.root.join('app/assets/images/no_img.png')
    default_image = File.open(file_path)
    images.attach(io: default_image, filename: 'default-image.png', content_type: 'image/png')
    images
  end
  end

    
  
end
