class PaymentDebit < ApplicationRecord
	attr_accessor :date_label
	
	belongs_to :payment_request
	belongs_to :rate
	belongs_to :rate_risk_adjustment

	enum status: [:pending]

	after_create :clean_debit

	private ##

	def clean_debit
		payment_request.payment_debits.where.not(id: self.id).destroy_all
	end
end
