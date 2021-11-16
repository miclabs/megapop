class RateCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rate_card, only: [:show, :edit, :update, :destroy]

  def index
    @rate_cards = if params[:card_type].present?
      RateCard.send(params[:card_type])
    else
      RateCard.all
    end
  end

  def update
    if @rate_card.update(rate_card_params.merge(updated_by_id: current_user.id))
      redirect_to rate_cards_path(card_type: @rate_card.card_type), notice: 'Updated successfully'
    else
      flash[:error] = @rate_card.errors.full_messages.to_sentence
      render :edit
    end
  end

  def new
    @rate_card = RateCard.new card_type: params[:card_type]
    @rate_card.rates.build
    @rate_card.rate_risk_adjustments.build
  end

  def create
    @rate_card = RateCard.new rate_card_params.merge(created_by_id: current_user.id)

    if @rate_card.save
      redirect_to rate_cards_path(card_type: @rate_card.card_type), notice: 'Created successfully'
    else
      flash[:error] = @rate_card.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if @rate_card.destroy
      redirect_to rate_cards_path(card_type: @rate_card.card_type), notice: 'Destroyed successfully'
    else
      flash[:error] = @rate_card.errors.full_messages.to_sentence
      redirect_to rate_cards_path
    end
  end

  private ##

  def set_rate_card
    @rate_card = RateCard.find(params[:id])
  end

  def rate_card_params
    params.require(:rate_card).permit(
      :name, :card_type, :primary,
      rates_attributes: [:id, :rate, :days, :_destroy],
      rate_risk_adjustments_attributes: [
        :id, :min_score, :max_score, :risk_value,
        :credit_tier, :eleigible_for_offer, :_destroy
      ]
    )
  end
end