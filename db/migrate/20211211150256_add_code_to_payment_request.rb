class AddCodeToPaymentRequest < ActiveRecord::Migration[6.1]
  def change
  	add_column :payment_requests, :code, :string

  	PaymentRequest.find_each do |p|
  		p.send(:set_code)
  		p.save
  	end
  end
end
