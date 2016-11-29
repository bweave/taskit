class CardCreatedJob < ApplicationJob
  queue_as :default

  def perform(card)
    ActionCable.server.broadcast "cards_channel", {
      card_id: card.id,
      list_id: card.list_id,
      cardHtml: CardsController.render(card),
    }
  end
end
