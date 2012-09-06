class RenameColumnFromRetweetCountToRetweetedCount < ActiveRecord::Migration
  def up
    rename_column :items, :retweet_count, :retweeted_count
  end

  def down
    rename_column :items, :retweeted_count, :retweet_count
  end
end
