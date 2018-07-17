class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :sender, index: true, foreign_key: { to_table: :users }
      t.references :recipient, index: true, foreign_key: { to_table: :users }
      t.boolean :friendship, default: 0
      t.datetime :friendship_at, null: true
      t.boolean :subscribed, default: 0
      t.datetime :subscribed_at, null: true
      t.string :current_status, null: true
      t.datetime :current_status_at, null: true
      t.timestamps
    end
  end
end
