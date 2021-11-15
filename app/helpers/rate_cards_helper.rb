module RateCardsHelper
  def is_primary?
    RateCard.send(@rate_card.card_type).primary.where.not(id: @rate_card.id).any?
  end
end
