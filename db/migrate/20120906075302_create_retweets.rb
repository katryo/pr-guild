class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :user
      t.references :item

      t.timestamps
    end
    add_index :retweets, :user_id
    add_index :retweets, :item_id
  end
end
