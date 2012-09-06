class RemoveIconUrlTwitterFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :icon_url_twitter
      end

  def down
    add_column :users, :icon_url_twitter, :string
  end
end
