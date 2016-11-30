# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ListsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "lists_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
