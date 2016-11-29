App.cards = App.cable.subscriptions.create("CardsChannel", {
  // Called when the subscription is ready for use on the server
  connected: function() {
    console.log('CardsChannel.connected');
  },

  // Called when the subscription has been terminated by the server
  disconnected: function() {
    console.log('CardsChannel.disconnected');
  },

  // Called when there's incoming data on the websocket for this channel
  received: function(data) {
    let $card = $(".card[data-id='" + data.card_id + "']"),
        $cards = $(".cards[data-list_id='" + data.list_id + "']");

    console.log(data);

    if ($card.length > 0) return false;

    return $cards.append(data.cardHtml);
  }
});
