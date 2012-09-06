class AddRetweetCountToItems < ActiveRecord::Migration
  def change
    add_column :items, :retweet_count, :integer, :default => 0
  end
end
