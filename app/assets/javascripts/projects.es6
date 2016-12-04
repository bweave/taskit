$(function() {

  function _updateOrder($items) {
    return $items.map(function(i, item) {
      return {id: item.dataset.id, position: i+1};
    }).toArray();
  }

  let container = $('#lists-container').toArray();
  let draggableLists = dragula(container, {
    direction: 'horizontal',
    moves: function(el, source, handle, sibling) {
      return handle.classList.contains('handle');
    }
  });

  draggableLists.on('drop', function(el, target, source, sibling) {
    let slug = el.parentElement.dataset.project_slug,
        url = `/projects/${slug}/lists/sort`,
        els = $('.list', source),
        updatedOrder = _updateOrder(els);

    $.ajax(url, {
      type: 'PUT',
      data: {order: updatedOrder}
    });
  });

  let draggableCards = dragula($('.cards').toArray())
    .on('drag', function() {
      this.containers.forEach(c => { c.classList.add('ex-card-dragging') });
    })
    .on('dragend', function() {
      this.containers.forEach(c => { c.classList.remove('ex-card-dragging') });
    })
    .on('drop', function(el, target, source, sibling) {
      let listId = target.dataset.list_id,
          url = `/lists/${listId}/cards/sort`,
          els = $('.card', target),
          updatedOrder = _updateOrder(els);

      $.ajax(url, {
        type: 'PUT',
        data: {order: updatedOrder}
      });
    });


  $('#lists-container').on('click touchstart', '.list .header .actions-menu', function(e) {
    e.preventDefault();
    let $this = $(this);
    $this.toggleClass('fa-bars').toggleClass('fa-close');
    $this.siblings('.actions').toggleClass('hide');
  });

});


