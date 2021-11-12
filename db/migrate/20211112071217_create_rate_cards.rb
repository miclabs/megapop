class CreateRateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :rate_cards do |t|
      t.integer :card_type
      t.string :name
      t.boolean :primary
      t.integer :user_id

      t.timestamps
    end
  end
end
