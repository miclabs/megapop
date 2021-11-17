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
      extension_rate: 'Extension Rate'
    }
  end

  def boolean_collection
    [['Yes', true], ['No', false]]
  end
end