class CreatePaymentRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_requests do |t|
      t.string :sponsor_name
      t.integer :social_platform
      t.float :project_amount
      t.float :debt_amount
      t.datetime :expected_payment_date
      t.boolean :job_complete
      t.integer :sponsorship_type
      t.integer :status, default: 0
      t.integer :created_by_id

      t.timestamps
    end
  end
end
