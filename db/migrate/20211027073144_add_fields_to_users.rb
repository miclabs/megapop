class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :street_address_1, :string
    add_column :users, :street_address_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :zip_code, :string
    add_column :users, :dob, :string
    add_column :users, :status, :boolean, default: true
    add_column :users, :role, :integer, null: false, default: 0
  end
end
