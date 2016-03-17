class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :username, :string

    User.find_each do |user|
      user.username = user.email.split('@').first
      user.save!
    end

    change_column_null :users, :username, false
  end

  def down
    remove_column :users, :username
  end
end
