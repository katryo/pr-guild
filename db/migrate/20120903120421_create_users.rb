class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider_twitter
      t.string :uid_twitter
      t.string :name_twitter
      t.integer :point
      t.integer :retweets_count

      t.timestamps
    end
  end
end
