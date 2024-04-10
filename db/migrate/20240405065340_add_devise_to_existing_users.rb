class AddDeviseToExistingUsers < ActiveRecord::Migration[7.1]
  def change
    # Assuming `email` already exists, so it's not added here
    add_column :users, :encrypted_password, :string, null: false, default: ""
    
    ## Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    
    ## Rememberable
    add_column :users, :remember_created_at, :datetime

    ## Trackable
    add_column :users, :sign_in_count, :integer, null: false, default: 0
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string

    # Ensure you don't add an index for email if it already exists
    # add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
