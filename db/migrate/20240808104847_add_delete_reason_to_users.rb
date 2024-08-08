class AddDeleteReasonToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :delete_reason, :text
  end
end
