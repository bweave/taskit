class CardRelayJob < ApplicationJob
  queue_as :default

  def perform(card)
    logger.debug "\n===== Performing the CardRelayJob with #{card.attributes.inspect} =====\n"
    ActionCable.server.broadcast "cards_channel", {
      card_id: card.id,
      card_position: card.position,
      list_id: card.list_id,
      card_html: CardsController.render(card),
    }
  end
end
