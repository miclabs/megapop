class RateCard < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  belongs_to :updated_by, class_name: 'User', foreign_key: :updated_by_id, required: false

  has_many :rates

  enum card_type: { interest_rate: 0, extension_rate: 1 }

  accepts_nested_attributes_for :rates, reject_if: :all_blank, allow_destroy: true

  validates :name, :rates, presence: true

  scope :primary, -> { where(primary: true) }

  before_commit :update_primary

  def update_primary
    if primary?
      self.class.send(self.card_type).primary.where.not(id: id).update(primary: false)
    end
  end
end
