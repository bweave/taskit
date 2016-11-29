# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class CardsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cards_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
