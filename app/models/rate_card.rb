class RateCard < ApplicationRecord
  belongs_to :user
  has_many :rates

  enum card_type: { interest_rate: 0, extension_rate: 1 }

  validates :name, :rates, presence: true

  accepts_nested_attributes_for :rates, reject_if: :all_blank, allow_destroy: true
end
