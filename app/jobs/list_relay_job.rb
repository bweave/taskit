class ListRelayJob < ApplicationJob
  queue_as :default

  def perform(list)
    ActionCable.server.broadcast "lists_channel", {
      list_id: list.id,
      list_position: list.position,
      list_name: list.name,
      list_html: ListsController.render(list),
    }
  end
end
