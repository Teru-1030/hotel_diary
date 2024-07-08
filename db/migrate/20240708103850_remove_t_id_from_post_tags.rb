class RemoveTIdFromPostTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_tags, :t_id, :integer
  end
end
