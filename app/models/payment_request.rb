class PaymentRequest < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id, required: false

  has_many_attached :project_documents
  has_many :payment_debits

  accepts_nested_attributes_for :payment_debits, reject_if: :reject_debits, allow_destroy: true
  accepts_nested_attributes_for :created_by

  # validate unless: :draft?

  enum social_platform: ['Instagram', 'YouTube', 'TikTok', 'Twitter', 'Facebook']
  enum sponsorship_type: [:brand, :agency, :influencer_platform]
  enum status: [:draft, :submitted, :approved]

  default_scope -> { order(created_at: :desc) }

  before_create :set_code

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
        ) unless self.payment_debits.where(rate: rate, rate_risk_adjustment: adj).any?
      end
    end
  end

  private ##

  def set_code
    begin
      self.code = SecureRandom.hex(5).upcase
    end while self.class.exists?(code: code)
  end

  def reject_debits(attributes)
    attributes['active'].blank?
  end
end
