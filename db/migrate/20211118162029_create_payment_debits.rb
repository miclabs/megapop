class CreatePaymentDebits < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_debits do |t|
      t.integer :payment_request_id
      t.integer :rate_id
      t.integer :rate_risk_adjustment_id
      t.decimal :collection_amount
      t.datetime :collection_date
      t.boolean :active, default: false
      t.integer :status, default: 0
      t.float :credit_score

      t.timestamps
    end
  end
end
