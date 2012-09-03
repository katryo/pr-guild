class AddIconUrlTwitterToUser < ActiveRecord::Migration
  def change
    add_column :users, :icon_url_twitter, :integer
  end
end
