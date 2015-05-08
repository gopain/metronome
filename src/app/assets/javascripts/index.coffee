$ ->
  ($ 'span.timeago').timeago()
  ($ 'ul.pagination li.unavailable').click (e) -> e.preventDefault()
  ($ 'ul.side-nav li').each ->
    pathname = location.pathname
    if (pathname.split '/').pop() is $(@).data('tab-item')
      $(@).addClass 'active'
  ($ '.alert-box a.close').click (e) ->
    e.preventDefault()
    $(@).parent().fadeOut(200)

  likeable = $ '.topic.show .likeable'
  if likeable.length
    $.get (likeable.data 'url'), (data) ->
      if data.likeable and data.like
        likeable.addClass 'actived'
        likeable.children 'a'
          .data 'method', 'delete'
          .attr 'href', (likeable.data 'url').replace 'likeable', 'unlike'
