class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.float :rate
      t.integer :days
      t.integer :rate_card_id

      t.timestamps
    end
  end
end
