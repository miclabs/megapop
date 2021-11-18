class CreateRateRiskAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :rate_risk_adjustments do |t|
      t.integer :min_score
      t.integer :max_score
      t.float :risk_value
      t.integer :credit_tier
      t.boolean :eleigible_for_offer
      t.integer :rate_card_id

      t.timestamps
    end
  end
end
