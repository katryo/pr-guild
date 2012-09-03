class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :retweet_count
      t.references :user

      t.timestamps
    end
    add_index :items, :user_id
  end
end
