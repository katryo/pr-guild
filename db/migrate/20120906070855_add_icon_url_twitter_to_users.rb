class AddIconUrlTwitterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :icon_url_twitter, :string
  end
end
