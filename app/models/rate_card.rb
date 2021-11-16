class RateCard < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  belongs_to :updated_by, class_name: 'User', foreign_key: :updated_by_id, required: false

  has_many :rates
  has_many :rate_risk_adjustments

  enum card_type: { interest_rate: 0, extension_rate: 1, ir_risk_adjustment: 2, er_risk_adjustment: 3 }

  accepts_nested_attributes_for :rates, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :rate_risk_adjustments, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  validates :rates, presence: true, if: :is_rate_type?
  validates :rate_risk_adjustments, presence: true, if: :is_rate_risk_adjustment_type?

  scope :primary, -> { where(primary: true) }

  before_commit :update_primary

  private ##

  def update_primary
    if primary?
      self.class.send(self.card_type).primary.where.not(id: id).update(primary: false)
    end
  end

  def is_rate_type?
    ['interest_rate', 'extension_rate'].include?(card_type)
  end

  def is_rate_risk_adjustment_type?
    ['ir_risk_adjustment', 'er_risk_adjustment'].include?(card_type)
  end

end
