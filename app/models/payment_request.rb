class PaymentRequest < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id, required: false

  has_many_attached :project_documents
  has_many :payment_debits

  accepts_nested_attributes_for :payment_debits, reject_if: :all_blank, allow_destroy: true

  # validate unless: :draft?

  enum social_platform: ['Instagram', 'YouTube', 'TikTok', 'Twitter', 'Facebook']
  enum sponsorship_type: [:brand, :agency, :influencer_platform]
  enum status: [:draft, :submitted]

  def init_payment_debits
    rates = RateCard.primary.interest_rate.first.rates
    rate_risk_adjustments = RateCard.primary.ir_risk_adjustment.first.rate_risk_adjustments
    user_rate_risk_adjustments = rate_risk_adjustments.for_user(created_by)
    
    rates.each do |rate|
      user_rate_risk_adjustments.each do |adj|
        self.payment_debits.build(
          rate: rate,
          rate_risk_adjustment: adj,
          collection_amount: rate.rate + adj.risk_value,
          collection_date: rate.days.days.from_now,
          credit_score: nil
        )
      end
    end
  end
end
