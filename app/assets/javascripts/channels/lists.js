App.lists = App.cable.subscriptions.create("ListsChannel", {
  // Called when the subscription is ready for use on the server
  connected: function() {
    console.log('ListsChannel.connected');
  },
  // Called when the subscription has been terminated by the server
  disconnected: function() {
    console.log('ListsChannel.disconnected');
  },
  // Called when there's incoming data on the websocket for this channel
  received: function(data) {
    console.log(data);
    let $list = $(`.list[data-id="${data.list_id}"]`);

    if (this.listExists($list)) {
      return this.updateList($list, data);
    }

    return this.createList(data.list_id, data.list_html);
  },

  listExists: function($list) {
    return ($list.length > 0);
  },

  createList: function(listId, listHtml) {
    let $listsContainer = $('#lists-container'),
        listMarker = `created_list_${listId}`;

    $(listHtml).insertBefore('#new-list');

    if ($listsContainer.data(listMarker) == true) {
      $listsContainer.scrollLeft($listsContainer.prop('scrollWidth'));
      $listsContainer.removeData(listMarker);
    }
  },

  updateList: function($list, data) {
    let $listName = $(`.list[data-id="${data.list_id}"] .list-name`);
    $listName.text(data.list_name);

    $listSibling = $(`.list:nth-child(${data.list_position})`, '#lists-container');
    if ($listSibling.length > 0) $listSibling.before($list);

    return $list;
  }
});
