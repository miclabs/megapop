class AddCreatedByIdToRateCard < ActiveRecord::Migration[6.1]
  def change
    add_column :rate_cards, :created_by_id, :integer
    add_column :rate_cards, :updated_by_id, :integer
  end
end
