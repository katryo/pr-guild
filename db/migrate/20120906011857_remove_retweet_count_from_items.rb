class RemoveRetweetCountFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :retweet_count
      end

  def down
    add_column :items, :retweet_count, :string
  end
end
