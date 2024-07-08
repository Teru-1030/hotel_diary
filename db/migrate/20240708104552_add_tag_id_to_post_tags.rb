class AddTagIdToPostTags < ActiveRecord::Migration[6.1]
  def change
    add_column :post_tags, :tag_id, :integer
  end
end
