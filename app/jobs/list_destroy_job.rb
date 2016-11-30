class ListDestroyJob < ApplicationJob
  queue_as :default

  def perform(list_id)
    ActionCable.server.broadcast "lists_channel", {
      list_id: list_id,
      destroy: true,
    }
  end
end
