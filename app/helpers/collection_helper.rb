module CollectionHelper
   def user_roles
    {
      creator: 'Creator',
      credit_manager: 'Credit Manager',
      admin: 'Administrator'
    }
  end

  def rate_card_types
    {
      interest_rate: 'Interest Rate',
      extension_rate: 'Extension Rate',
      ir_risk_adjustment: 'Interest Rate Risk Adjustment',
      er_risk_adjustment: 'Extension Rate Risk Adjustment'
    }
  end

  def boolean_collection
    [['Yes', true], ['No', false]]
  end

  def rate_types_collection
    [:interest_rate, :extension_rate]
  end

  def credit_tiers
    RateRiskAdjustment.credit_tiers.invert.values.map { |credit_tier| [credit_tier, credit_tier]}
  end
end