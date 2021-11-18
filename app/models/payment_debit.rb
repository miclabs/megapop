class PaymentDebit < ApplicationRecord
	attr_accessor :date_label
	
	belongs_to :payment_request
	belongs_to :rate
	belongs_to :rate_risk_adjustment

	enum status: [:pending]
end
