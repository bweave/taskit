class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:update, :destroy]

  def show
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.json { render json: @card }
        format.js {}
      else
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.json { render :show, status: :ok, location: @card }
      else
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:order].each do |key,value|
      Card.find(value[:id]).update(list_id: params['list_id'], position: value[:position])
    end
    render :nothing => true
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.json { head :no_content }
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
