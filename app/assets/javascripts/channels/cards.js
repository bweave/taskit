App.cards = App.cable.subscriptions.create('CardsChannel', {
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
    console.log(data);
    let $card = $(`.card[data-id="${data.card_id}"]`);

    if (this.cardExists($card)) {
      return this.updateCard($card, data);
    }

    return this.createCard(data.list_id, data.card_html);
  },

  cardExists: function($card) {
    return ($card.length > 0);
  },

  createCard: function(listId, cardHtml) {
    let $cards = $(`.cards[data-list_id="${listId}"]`);
    return $cards.append(cardHtml);
  },

  updateCard: function($card, data) {
    let $currentList = $card.parents('.cards'),
        listId = $currentList.data('list_id');

    if (listId !== data.list_id) {
      let $newList = $(`.cards[data-list_id="${data.list_id}"]`);
      $newList.append($card);
    }

    $card.replaceWith(data.card_html);
  }
});
