class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true, index: { unique: true }
      t.references :friend, foreign_key: { to_table: 'users' }, index: { unique: true }
      t.string :status

      t.timestamps
    end
  end
end
