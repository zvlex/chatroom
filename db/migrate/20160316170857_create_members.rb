class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.integer :room_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :members, [:room_id, :user_id], unique: true
  end
end
