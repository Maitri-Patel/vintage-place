class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      # Uncomment or add only the new Devise columns your users table doesn't already have
      # Example: t.string :reset_password_token
      
      # Add indexes only for columns that don't already have them
      # Example: t.index :reset_password_token, unique: true
    end
    # Don't forget to add any missing indexes for the new columns
  end
end
