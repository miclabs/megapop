class RateRiskAdjustment < ApplicationRecord
  belongs_to :rate_card

  enum credit_tier: ['Flawless', 'Excellent', 'Good', 'Mediocre', 'Not Good', 'Poor', 'Very Poor']
end
