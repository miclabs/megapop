class AddSsnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ssn, :string
  end
end
