class RateCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rate_card, only: [:show, :edit, :update, :destroy]

  def index
    @rate_cards = params[:card_type].present? ? current_user.rate_cards.send(params[:card_type]) : current_user.rate_cards
  end

  def update
    if @rate_card.update(rate_card_params)
      redirect_to rate_cards_path, notice: 'Updated successfully'
    else
      flash[:error] = @rate_card.errors.full_messages.to_sentence
      render :edit
    end
  end

  def new
    @rate_card = current_user.rate_cards.new card_type: params[:card_type]
    @rate_card.rates.build
  end

  def create
    @rate_card = current_user.rate_cards.new rate_card_params

    if @rate_card.save
      redirect_to rate_cards_path, notice: 'Created successfully'
    else
      flash[:error] = @rate_card.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if @rate_card.destroy
      redirect_to rate_cards_path, notice: 'Destroyed successfully'
    else
      flash[:error] = @rate_card.errors.full_messages.to_sentence
      redirect_to rate_cards_path
    end
  end

  private ##

  def set_rate_card
    @rate_card = current_user.rate_cards.find(params[:id])
  end

  def rate_card_params
    params.require(:rate_card).permit(
      :name, :card_type, :primary,
      rates_attributes: [:id, :rate, :days, :_destroy]
    )
  end
end