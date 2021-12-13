class RateRiskAdjustment < ApplicationRecord
  belongs_to :rate_card

  enum credit_tier: [
  	'Flawless', 'Excellent', 'Good', 'Mediocre', 'Not Good', 'Poor', 'Very Poor'
  ]

  scope :for_user, -> (user) { where("min_score <= :score AND max_score > :score", score: user.credit_score) }
end
