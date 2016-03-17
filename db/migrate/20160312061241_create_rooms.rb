class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :is_visible, null: false, default: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :rooms, :name, unique: true
  end
end
