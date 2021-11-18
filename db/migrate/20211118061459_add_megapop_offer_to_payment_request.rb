class AddMegapopOfferToPaymentRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_requests, :megapop_offer, :integer
  end
end
