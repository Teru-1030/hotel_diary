class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      
      t.integer :post_id
      t.text :image_url
      t.timestamps
    end
  end
end
