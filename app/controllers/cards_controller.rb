class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:edit, :update, :destroy]

  def show
  end

  def create
    @card = Card.new(card_params)
    logger.debug "\n===== New card: #{@card.attributes.inspect} =====\n"

    respond_to do |format|
      if @card.save
        format.js {}
        logger.debug "\n===== The card was saved: #{@card.attributes.inspect} =====\n"
        CardRelayJob.perform_later(@card)
        logger.debug "\n===== The CardRelayJob was was created =====\n"
      else
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.js {}
        CardRelayJob.perform_later(@card)
      else
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:order].each do |key,value|
      card = Card.find(value[:id])
      card.update(list_id: params['list_id'], position: value[:position])
      CardRelayJob.perform_later(card)
    end
    render :nothing => true
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.js {}
      CardDestroyJob.perform_later(@card.id)
    end
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:list_id, :name, :description)
    end
end
