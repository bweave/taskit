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
    console.debug('Recieved data: ', data);
    let $card = $(`.card[data-id="${data.card_id}"]`);

    if (data.destroy) {
      console.debug('Destroying card');
      return $card.remove();
    }

    if (this.cardExists($card)) {
      console.debug('The card exists, going to update it');
      return this.updateCard($card, data);
    }

    console.debug('Creating the card');
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
    console.debug('Updating the card');
    function _updateList($card, data) {
      console.debug('Updating the card list');
      let $currentList = $card.parents('.cards'),
          listId = $currentList.data('list_id'),
          $listToUpdate,
          $cardSibling;

      $listToUpdate = (listId === data.list_id) ? $currentList : $(`.cards[data-list_id="${data.list_id}"]`);
      $cardSibling = $(`.card:nth-child(${data.card_position})`, $listToUpdate);

      if ($cardSibling.length < 1) return $listToUpdate.append($card);

      return $cardSibling.before($card);
    }

    function _updateContent($card, html) {
      console.debug('Updating the card content');
      return $card.replaceWith(html);
    }

    _updateList($card, data);
    _updateContent($card, data.card_html);

    return $card;
  }
});
