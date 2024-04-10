class RemoveAddressFieldsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :address, :string
    remove_column :users, :city, :string
    remove_column :users, :province, :string
    remove_column :users, :postal_code, :string
  end
end
