class CardDestroyJob < ApplicationJob
  queue_as :default

  def perform(card_id)
    ActionCable.server.broadcast "cards_channel", {
      card_id: card_id,
      destroy: true,
    }
  end
end
